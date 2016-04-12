require "pstore"
require "yaml/store"

class PS


	@@db = YAML::Store.new("data/db.yaml")

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