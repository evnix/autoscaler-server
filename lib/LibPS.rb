require "pstore"
require "yaml/store"

class LibPS

	#uses eager initialization approach
	@@db = PStore.new("data/db.pstore")


	def self.getInstance()

		return LibPS.new
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