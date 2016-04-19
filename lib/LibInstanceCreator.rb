require_relative "./LibConfig"
require_relative "./libPStore.rb"
require_relative "./StoreFactory.rb"
require_relative "./LibInstance.rb"
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

							ps=StoreFactory.getStore("YAML")

			if ps.Get("p/"+objConfig["name"]+"/running",0) < objConfig["minInstances"]

				time = Time.now

				if PS.get("p/"+objConfig["name"]+"/wait",time) <= time

					self.startInstances(objConfig["name"],objConfig["minInstances"])

				else

						p "Run.Ins.waiting"
				end
					
					

			else

					p "minInstances already running.. trying required instances"

					running=PS.get("p/"+objConfig["name"]+"/running",0).to_i()
					required= PS.get("p/"+objConfig["name"]+"/required",0).to_i()+ objConfig["minInstances"].to_i()

					if running < required

						time = Time.now

						if PS.get("p/"+objConfig["name"]+"/wait",time) <= time

							self.startInstances(objConfig["name"],required-running)

						else

								p "Req.Ins.waiting"
						end

					end

			end

	end



	def startInstances(name,minInstances)

		for i in 1..minInstances



				obj =  VM.new( BasicInstance.new)
				obj2=obj.set_os("ubuntu")

				obj3 = Vultr.new(obj2)
				obj4=obj3.set_data()

				#url = URI.parse('https://api.vultr.com/v1/server/create')
				url = URI.parse(obj4.get_url())

				http = Net::HTTP.new(url.host, url.port)
				http.use_ssl = true

				#data = "DCID=8&VPSPLANID=29&OSID=160&SSHKEYID=57045f3be75c5"
				data = obj4.get_params()

				headers = {
				  #'API-Key' => '34KSOMQICL5OCDFETXTV6AVZPYW3O4'
				  'API-Key' => obj4.get_header('API-Key')
				}

				resp = http.post(url.path, data, headers)
				puts resp.body

				count = PS.get("p/"+name+"/running",0)
				count =count + 1
				PS.set("p/"+name+"/running",count)

				PS.set("p/"+name+"/wait",(Time.now + 5*60))

            	PS.set("p/"+name+"/latest",(Time.now))

				jstr = PS.get("p/"+name+"/subids","[]")
				subids = JSON.parse(jstr)

				respObj = JSON.parse(resp.body)

				subId = respObj["SUBID"]

				subids.push(subId)

				jstr = JSON.generate(subids)
				PS.set("p/"+name+"/subids",jstr)

				return subId
		end


	end

end