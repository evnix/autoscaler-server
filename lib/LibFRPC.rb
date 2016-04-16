require 'LibFIPC'
require 'json'

class FRPC < FIPC

	def self.exec(channel,function,*args)

		obj={}
		obj["cmd"]="RPC"
		obj["function"] = function
		obj["args"] = args
		strJSON = JSON.generate(obj)
		self.sendMsg(channel,strJSON)
	end


	def self.run(cmd)


        if cmd == false
            return false
        end
        
        
		obj=JSON.parse(cmd)

		if obj["cmd"] == "RPC"

			function=obj["function"]
			
			args=obj["args"]

			if args.length>0

				send( function,*args)

			else

				send(function)

			end

			return true

		else

			return false
		end

	end

end
