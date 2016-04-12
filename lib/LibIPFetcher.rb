require_relative "./LibConfig"
require_relative "./libPStore.rb"
require 'net/http'
require 'net/https'
require 'uri'
require 'time'
require "json"

class LibIPFetcher


	def fetchIPs()

		p JSON.parse(self._fetchData())
	end



	def self._fetchData()


			return File.read("dump.txt")

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