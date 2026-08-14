(function(global){"use strict";
var K="leh_oauth_return",MAX=20,DELAY=500;
function valid(v){return typeof v==="string"&&v.indexOf("/")===0&&v.indexOf("//")!==0?v:""}
function save(){try{var p=new URLSearchParams(global.location.search),t=p.get("redirect")||p.get("returnTo")||p.get("next");if(!t&&global.location.pathname.indexOf("/learning/")===0)t=global.location.pathname+global.location.search;if(valid(t)){localStorage.setItem(K,t);sessionStorage.setItem(K,t)}}catch(_){}}
function target(){try{var t=sessionStorage.getItem(K)||localStorage.getItem(K);return valid(t)||"/dashboard/"}catch(_){return"/dashboard/"}}
function clear(){try{sessionStorage.removeItem(K);localStorage.removeItem(K)}catch(_){}}
function client(){if(global.supabaseClient&&global.supabaseClient.auth)return global.supabaseClient;if(global.lehSupabase&&global.lehSupabase.auth)return global.lehSupabase;return null}
async function get(){var c=client();if(!c||!c.auth||typeof c.auth.getSession!=="function")return null;try{var r=await c.auth.getSession();return r&&r.data&&r.data.session?r.data.session:null}catch(_){return null}}
async function wait(){for(var i=0;i<MAX;i++){var s=await get();if(s&&s.user)return s;await new Promise(function(r){setTimeout(r,DELAY)})}return null}
async function handle(){save();var s=await wait();if(s&&s.user&&(global.location.pathname==="/auth/sign-in.html"||global.location.pathname==="/dashboard-router.html")){var t=target();clear();global.location.replace(t)}}
global.LEHOAuthReturn={saveTarget:save,getSession:wait,handle:handle};
if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",handle);else handle();
})(window);
