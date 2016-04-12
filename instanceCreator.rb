require_relative "lib/ServerConfig"
require_relative "lib/initConfig"
require_relative "lib/LibInstanceCreator"
require_relative "lib/LibFRPC.rb"


IC= LibInstanceCreator.new()

def main()

    puts IC.createInstances()
    FRPC.run(FRPC.receiveMsg("channels/instanceCreator"))
    FRPC.exec("channels/supervisor","counter_inc","instanceCreator")
    sleep(2)
     

end 

def stop_server()

    abort("instanceCreator terminated by supervisor.")

end





while true do

    main()

end

