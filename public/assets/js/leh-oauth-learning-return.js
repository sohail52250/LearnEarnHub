(function(global){
"use strict";

var KEY="leh_oauth_return_to";
var DEFAULT="/learning/";

function safe(value){
    if(!value) return DEFAULT;
    try{
        value=decodeURIComponent(value);
    }catch(_){
        return DEFAULT;
    }
    if(value.charAt(0)!=="/") return DEFAULT;
    if(value.indexOf("//")===0) return DEFAULT;
    return value;
}

function remember(value){
    var target=safe(value);
    localStorage.setItem(KEY,target);
    return target;
}

function get(){
    return safe(localStorage.getItem(KEY)||DEFAULT);
}

function clear(){
    localStorage.removeItem(KEY);
}

global.LEHOAuthLearningReturn={
    remember:remember,
    get:get,
    clear:clear,
    safeReturn:safe
};

})(window);
