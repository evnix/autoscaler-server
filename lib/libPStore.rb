require "pstore"
require "yaml/store"

class PS

	#uses eager initialization approach
	@@db = YAML::Store.new("data/db.yaml")


	def self.getInstance()

		return PS.new
	end


	def Get(key,default=nil)
		LibPS.get(key,default)
	end


	def Set(key,value)
		LibPS.set(key,value)
	end
	
	def self.get(key,default=nil)
		

		@@db.transaction do
			
			val = @@db[key]

			if val == nil
				return default
			end

			return val

		end


	end

	def self.set(key,value)

		

		@@db.transaction do
			
			@@db[key]=value

		end
	end


end