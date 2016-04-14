require_relative "lib/ServerConfig"
require_relative "lib/initConfig"
require_relative "lib/LibIPFetcher"
require_relative "lib/LibFRPC.rb"


IF= LibIPFetcher.new()

def main()

	p "IP-F"
    IF.fetchIPs()
    FRPC.run(FRPC.receiveMsg("channels/IPFetcher"))



    sleep(15)
     

end 

def stop_server()

    abort("IPFetcher terminated by supervisor.")

end


thr = Thread.new { 

	while true do

    	FRPC.exec("channels/supervisor","counter_inc","IPFetcher")

		sleep(2)

	end

}


while true do

    main()

end

