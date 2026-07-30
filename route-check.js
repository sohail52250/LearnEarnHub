const app = require("./server");

console.log("===== EXPRESS ROUTES =====");

for (const r of app.router.stack) {

  if (r.route) {
    console.log(
      "DIRECT:",
      r.route.path,
      Object.keys(r.route.methods)
    );
  }

  if (r.name === "router") {
    console.log("ROUTER:");

    for (const s of r.handle.stack) {
      console.log(
        "  PATH:",
        s.route?.path,
        "METHODS:",
        s.route ? Object.keys(s.route.methods) : []
      );
    }
  }
}
