module.exports = {
    "database" : "mongodb://aditya:aditya123@ds113702.mlab.com:13702/userstoriesdb",
    "PORT" : process.env.PORT || 5000,
    "secretKey" : "JSnPyRocks",
    "options": {
            "server":
                {
                    "socketOptions":
                         {
                             "keepAlive": 300000,
                             "connectTimeoutMS": 30000
                         }
                }, 
            "replset": 
                { 
                    "socketOptions":
                    {
                         "keepAlive": 300000,
                         "connectTimeoutMS" : 30000
                    }
                }
            }
};