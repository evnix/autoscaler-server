require_relative "./libPStore.rb"
require_relative "./LibPS.rb"



class StoreFactory


	def self.getStore(store=nil)

		if store == nil
			return PS.new
		end

		if store == "YAML"
			return PS.new
		end

		if store == "PStore"
			return LibPS.new
		end

		return nil

	end



	



end