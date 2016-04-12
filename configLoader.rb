require_relative "lib/ServerConfig"
require_relative "lib/initConfig"
require_relative "lib/LibConfig.rb"
require_relative "lib/LibFRPC.rb"


LC= LibConfig.new()

def main()

    puts "hello"
 	p LC.populateRepos()   
    FRPC.run(FRPC.receiveMsg("channels/configLoader"))
    FRPC.exec("channels/supervisor","counter_inc","configLoader")

    sleep(2)
     

end 

def stop_server()

    abort("codeupdater terminated by supervisor.")

end





while true do

    main()

end

