require_relative "lib/ServerConfig"
require_relative "lib/initConfig"
require_relative "lib/LibDeployer"
require_relative "lib/LibFRPC.rb"


DP= LibDeployer.new()

def main()

	p "L"
    DP.deploy()
    FRPC.run(FRPC.receiveMsg("channels/deployer"))
    FRPC.exec("channels/supervisor","counter_inc","deployer")
    sleep(2)
     

end 

def stop_server()

    abort("Deployer terminated by supervisor.")

end





while true do

    main()

end

