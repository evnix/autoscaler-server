require "json"




strConfig = File.read("server.config")
objConfig = JSON.parse(strConfig)
ServerConfig.set("configLocation",objConfig["configLocation"])
ServerConfig.set("repoLocation",objConfig["repoLocation"])
ServerConfig.set("repoHashLocation",objConfig["repoHashLocation"])
ServerConfig.set("tarLocation",objConfig["tarLocation"])