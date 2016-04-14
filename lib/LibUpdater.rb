require_relative "LibGit"
require 'open3'
require_relative "./libPStore.rb"


class LibUpdater


	def listRepos()

		dirs= Dir[ServerConfig.get("repoLocation")+"/*"]

		repos=[]

		dirs.each {

			|dir|


			if  Dir.exists?(dir+"/.git")

				repos.push(dir)

			end

		}


		return repos



	end


	def getOutdatedRepos(repos)

		repos.each{

			|repo|


			localHash =	LibGit.getLocalHash(repo,"release")
			remoteHash = LibGit.getRemoteHash(repo,"release")



			parts=repo.split("/")

			name=parts[parts.length-1]

			if localHash != remoteHash
				LibGit.pullChanges(repo,"release")
				PS.set("p/"+name+"/latest",(Time.now))

				cmd = "git --git-dir="+repo+"/.git --work-tree="+repo+" archive -o "+ServerConfig.get("tarLocation")+"/"+name+".tar.gz HEAD"
				out, err, st = Open3.capture3(cmd)  

			end


		}



	end

	def updateRepos()

		repos=  listRepos()
		getOutdatedRepos(repos)
	end

end
