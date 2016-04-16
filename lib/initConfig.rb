require "json"




strConfig = File.read("server.config")
objConfig = JSON.parse(strConfig)

objConfig.each do |key,value|

	ServerConfig.set(key,value)
# ServerConfig.set("host",objConfig["host"])
# ServerConfig.set("configLocation",objConfig["configLocation"])
# ServerConfig.set("repoLocation",objConfig["repoLocation"])
# ServerConfig.set("repoHashLocation",objConfig["repoHashLocation"])
# ServerConfig.set("tarLocation",objConfig["tarLocation"])
# ServerConfig.set("secret",objConfig["secret"])
# ServerConfig.set("sampleSize",objConfig["sampleSize"])

end