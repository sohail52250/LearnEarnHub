const http = require("http");
const fs = require("fs");
const path = require("path");
const url = require("url");

const ROOT = path.join(__dirname, "public");
const PORT = Number(process.env.PORT || 3000);

const MIME = {
    ".html": "text/html; charset=utf-8",
    ".css": "text/css; charset=utf-8",
    ".js": "application/javascript; charset=utf-8",
    ".json": "application/json; charset=utf-8",
    ".svg": "image/svg+xml",
    ".png": "image/png",
    ".jpg": "image/jpeg",
    ".jpeg": "image/jpeg",
    ".webp": "image/webp",
    ".ico": "image/x-icon"
};

function safePath(requestPath) {
    const decoded = decodeURIComponent(requestPath);
    const clean = decoded.replace(/^\/+/, "");
    const target = path.normalize(path.join(ROOT, clean));

    if (!target.startsWith(ROOT)) {
        return null;
    }

    return target;
}

function send(res, status, body, type = "text/plain; charset=utf-8") {
    res.writeHead(status, {
        "Content-Type": type,
        "Cache-Control": "no-store"
    });

    res.end(body);
}

function serveFile(res, file) {
    fs.readFile(file, (err, data) => {
        if (err) {
            send(res, 404, "Not Found");
            return;
        }

        const ext = path.extname(file).toLowerCase();

        res.writeHead(200, {
            "Content-Type": MIME[ext] || "application/octet-stream",
            "Cache-Control": "no-cache"
        });

        res.end(data);
    });
}

const server = http.createServer((req, res) => {
    try {
        const parsed = url.parse(req.url);
        let pathname = parsed.pathname || "/";

        if (pathname === "/api/status") {
            send(
                res,
                200,
                JSON.stringify({
                    ok: true,
                    application: "LearnEarnHub",
                    architecture: "clean-reconstruction",
                    timestamp: new Date().toISOString()
                }),
                "application/json; charset=utf-8"
            );
            return;
        }

        if (pathname === "/health") {
            send(res, 200, "OK");
            return;
        }

        if (pathname === "/") {
            pathname = "/index.html";
        }

        const target = safePath(pathname);

        if (!target) {
            send(res, 403, "Forbidden");
            return;
        }

        fs.stat(target, (err, stat) => {
            if (!err && stat.isFile()) {
                serveFile(res, target);
                return;
            }

            if (!path.extname(target)) {
                const fallback = path.join(ROOT, "index.html");

                fs.stat(fallback, (fallbackErr) => {
                    if (!fallbackErr) {
                        serveFile(res, fallback);
                    } else {
                        send(res, 404, "Page Not Found");
                    }
                });

                return;
            }

            send(res, 404, "Not Found");
        });
    } catch (error) {
        console.error(error);
        send(res, 500, "Internal Server Error");
    }
});

server.listen(PORT, "127.0.0.1", () => {
    console.log(`LearnEarnHub running at http://127.0.0.1:${PORT}`);
});

process.on("SIGTERM", () => server.close());
process.on("SIGINT", () => server.close());
