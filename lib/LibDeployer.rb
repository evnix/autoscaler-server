require_relative "LibGit"
require 'open3'
require 'net/ssh'
require 'net/scp'
require_relative "./libPStore.rb"


class LibDeployer



	def deploy()
		repos =  listRepos()
		preDeploy(repos)
		return true
	end

	def listRepos()

		dirs= Dir[ServerConfig.get("repoLocation")+"/*"]

		repos=[]

		dirs.each {

			|dir|


			if  Dir.exists?(dir+"/.git")

				parts=dir.split("/")

				name=parts[parts.length-1]

				repos.push(name)

			end

		}


		return repos



	end


	def preDeploy(repos)

		repos.each{

			|repo|

					if PS.get("p/"+repo+"/running",0) >= 1

						time = Time.now

						if PS.get("p/"+repo+"/wait",time) <= time

							if (PS.get("p/"+repo+"/deployed") == nil) ||  ( PS.get("p/"+repo+"/deployed",Time.at(628232400)) < PS.get("p/"+repo+"/latest",Time.at(628232400)) )

									p "deploying..."
									doDeploy(repo)

							else
									p "Deployer: still old code for: "+repo
							end

						else

								p "Deployer: waiting"
						end
							
							

					else

							p "Deployer: atleast one instance required."
					end

		}


	end


	def doDeploy(repo)


		jstr = PS.get("p/"+repo+"/subids","[]")
		subids = JSON.parse(jstr)

		subids.each{

			|subid|

			ip = PS.get("s/"+subid+"/ip","0")
			if ip != "0"

					p "Deploying on IP: "+ip
					runSSH(repo,ip)
					PS.set("p/"+repo+"/deployed",Time.now)



			else
					p "No IP for subid: "+ subid

			end
		}


	end


	def runSSH(repo,ip)

			# Net::SCP.start(ip, "root") do |scp|
			#   # upload a file to a remote server

			#   			 scp.exec " cd ~ && ls"

			#   #scp.upload! +ServerConfig.get("tarLocation")+"/"+repo+".tar.gz", "~/file.tar.gz"

			#  #scp.exec " cd ~ && tar -xzvf file.tar.gz"



			# end

			Net::SSH.start(ip, 'root') do |ssh|
			  # capture all stderr and stdout output from a remote process
			  #output = ssh.exec!("ls")
			  ssh.exec!("mkdir -p /var/code/aa")
			  o=ssh.scp.upload! ServerConfig.get("tarLocation")+"/"+repo+".tar.gz", "/var/code/file.tar.gz"
			  p o
			  o=ssh.scp.upload! ServerConfig.get("tarLocation")+"/"+repo+".config", "/var/code/aa/agent.config"
			  p o
			  o=ssh.scp.upload! ServerConfig.get("baseLocation")+"/autoscaler-agent/agent.rb", "/var/code/aa/agent.rb"
			  p o
			  o=ssh.exec!("apt-get -y install ruby")
			  p o
			  o=ssh.exec!("gem install usagewatch")
			  p o
			  o=ssh.exec!("cd /var/code && tar -xzvf file.tar.gz")
			  p o
			  o=ssh.exec!("cd /var/code && chmod +x autoscaler.run")
			  p o
			  o=ssh.exec!("cd /var/code && ./autoscaler.run")
			  p o
			  o=ssh.exec!("pkill ruby")
			  p o
			  o=ssh.exec("cd /var/code/aa && ruby agent.rb > /dev/null &")
			  puts o
			  # capture only stdout matching a particular pattern
			 end

	end



end
