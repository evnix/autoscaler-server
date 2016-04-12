require_relative "./LibConfig"
require_relative "./libPStore.rb"
require 'net/http'
require 'net/https'
require 'uri'
require 'time'
require "json"

class LibInstanceCreator


	def createInstances

		configs=LibConfig._listConfigs()

		configs.each{

				|configFile|

				self._createInstances(configFile)
			}

	end



	def _createInstances(config)


			objConfig = LibConfig._getRepoConfig(config)


			if PS.get("p/"+objConfig["name"]+"/running",0) < objConfig["minInstances"]

				time = Time.now

				if PS.get("p/"+objConfig["name"]+"/wait",time) <= time

					self.startInstances(objConfig["name"],objConfig["minInstances"])

				else

						p "waiting"
				end
					
					

			else

					p "minInstances already running"
			end

	end



	def startInstances(name,minInstances)

		for i in 1..minInstances

				url = URI.parse('https://api.vultr.com/v1/server/create')

				http = Net::HTTP.new(url.host, url.port)
				http.use_ssl = true

				data = "DCID=8&VPSPLANID=29&OSID=160&SSHKEYID=57045f3be75c5"

				headers = {
				  'API-Key' => '34KSOMQICL5OCDFETXTV6AVZPYW3O4'
				}

				resp = http.post(url.path, data, headers)
				puts resp.body

				count = PS.get("p/"+name+"/running",0)
				count =count + 1
				PS.set("p/"+name+"/running",count)

				PS.set("p/"+name+"/wait",(Time.now + 5*60))


				jstr = PS.get("p/"+name+"/subids","[]")
				subids = JSON.parse(jstr)

				respObj = JSON.parse(resp.body)

				subId = respObj["SUBID"]

				subids.push(subId)

				jstr = JSON.generate(subids)
				PS.set("p/"+name+"/subids",jstr)

		end


	end

end