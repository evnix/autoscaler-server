require_relative "lib/ServerConfig"
require_relative "lib/initConfig"
require_relative "lib/LibIPFetcher"
require_relative "lib/LibFRPC.rb"


IF= LibIPFetcher.new()

def main()

    puts IF.fetchIPs()
    FRPC.run(FRPC.receiveMsg("channels/IPFetcher"))
    FRPC.exec("channels/supervisor","counter_inc","IPFetcher")
    sleep(2)
     

end 

def stop_server()

    abort("instanceCreator terminated by supervisor.")

end





while true do

    main()

end

