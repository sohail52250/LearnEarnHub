(function(global){
"use strict";

const API_BASE=(
    global.LEH_API_BASE ||
    (document.documentElement &&
     document.documentElement.dataset &&
     document.documentElement.dataset.apiBase) ||
    "/api"
).replace(/\/+$/,"");

function buildUrl(path){
    if(!path) return API_BASE;

    if(/^https?:\/\//i.test(path)){
        return path;
    }

    path=String(path);

    if(!path.startsWith("/")){
        path="/"+path;
    }

    if(path==="/api" || path.startsWith("/api/")){
        return path;
    }

    return API_BASE+path;
}

async function request(path,options){
    const opts=Object.assign({},options||{});
    const headers=Object.assign({},opts.headers||{});

    if(
        opts.body!==undefined &&
        opts.body!==null &&
        typeof opts.body!=="string" &&
        !(opts.body instanceof FormData)
    ){
        headers["Content-Type"]=
            headers["Content-Type"]||
            "application/json";

        opts.body=JSON.stringify(opts.body);
    }

    opts.headers=headers;

    if(!opts.credentials){
        opts.credentials="same-origin";
    }

    const response=await fetch(buildUrl(path),opts);

    const contentType=
        response.headers.get("content-type")||"";

    let data;

    if(contentType.includes("application/json")){
        data=await response.json();
    }else{
        data=await response.text();
    }

    if(!response.ok){
        const error=new Error(
            (data&&data.message)||
            (data&&data.error)||
            ("API request failed: "+response.status)
        );

        error.status=response.status;
        error.data=data;

        throw error;
    }

    return data;
}

const api={

    base:API_BASE,

    request:request,

    get:function(path,options){
        return request(
            path,
            Object.assign(
                {},
                options||{},
                {method:"GET"}
            )
        );
    },

    post:function(path,body,options){
        return request(
            path,
            Object.assign(
                {},
                options||{},
                {
                    method:"POST",
                    body:body
                }
            )
        );
    },

    put:function(path,body,options){
        return request(
            path,
            Object.assign(
                {},
                options||{},
                {
                    method:"PUT",
                    body:body
                }
            )
        );
    },

    patch:function(path,body,options){
        return request(
            path,
            Object.assign(
                {},
                options||{},
                {
                    method:"PATCH",
                    body:body
                }
            )
        );
    },

    delete:function(path,options){
        return request(
            path,
            Object.assign(
                {},
                options||{},
                {method:"DELETE"}
            )
        );
    },

    auth:function(body){
        return this.post("/auth",body);
    },

    courses:function(path,options){
        const suffix=path
            ? "/"+String(path).replace(/^\/+/,"")
            : "";

        return this.get("/courses"+suffix,options);
    },

    jobs:function(options){
        return this.get("/jobs",options);
    },

    feeds:function(options){
        return this.get("/feeds",options);
    }
};

global.LEH_API=api;

})(window);
