
const BaseConnector=require("./base-connector");


class CustomAPI extends BaseConnector {


constructor(){

super("Custom API");

}


async fetch(){

// Add approved API calls here later

return [];

}


}


module.exports=CustomAPI;

