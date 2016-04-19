require_relative "./LibConfig"
require_relative "./libPStore.rb"
require_relative "./LibInstance.rb"
require 'net/http'
require 'net/https'
require 'uri'
require 'time'
require "json"
require 'open-uri'

class LibIPFetcher


	def fetchIPs()

		vms = JSON.parse(LibIPFetcher._fetchData())
		self.store_ips(vms)
	end



	def self._fetchData()



			obj =  Vultr.new( BasicInstance.new)

			
			obj4=obj.set_IPfetcher()

			#str= open("https://api.vultr.com/v1/server/list",
			#		  "API-Key" => "34KSOMQICL5OCDFETXTV6AVZPYW3O4").read

			str= open(obj4.get_url(),
					  "API-Key" => obj4.get_header('API-Key')).read

			#p str
			return str


	end




	def store_ips(vms)

		vms.each{

			|vm|


			if vm[1]["main_ip"].length > 2

				PS.set("s/"+vm[1]["SUBID"]+"/ip",vm[1]["main_ip"])
			end  
		}


	end


end