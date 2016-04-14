require_relative "lib/ServerConfig"
require_relative "lib/initConfig"
require_relative "lib/LibDeployer"
require_relative "lib/LibFRPC.rb"

DP= LibDeployer.new()

def main()

	p "L"
    DP.deploy()
    FRPC.run(FRPC.receiveMsg("channels/deployer"))
    sleep(2)
     

end 

def stop_server()

    abort("Deployer terminated by supervisor.")

end



thr = Thread.new { 

	while true do

	FRPC.exec("channels/supervisor","counter_inc","deployer")

	p "TT"

	sleep(2)

	end

 }

while true do

    main()

end

