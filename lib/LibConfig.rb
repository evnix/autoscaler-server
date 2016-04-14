require "json"


class LibConfig


	def populateRepos()


			configs = LibConfig._listConfigs()

			configs.each{

				|configFile|

				LibConfig._populateRepo(configFile)
			}


	end


	def self._listConfigs()

			return Dir[ServerConfig.get("configLocation")+"/*.config"]
	end


	def self._populateRepo(repo)

			objConfig = LibConfig._getRepoConfig(repo)
			repoDir = objConfig["repoDir"]

			
			if not Dir.exists?(ServerConfig.get("repoLocation")+"/"+repoDir)

				repoURL = objConfig["repoURL"]
				system("git clone "+repoURL+" "+ServerConfig.get("repoLocation")+"/"+repoDir)

			end



	end


	def self._getRepoConfig(path)


		strConfig = File.read(path)
		objConfig = JSON.parse(strConfig)
		return objConfig


	end


end