require 'sinatra'
require 'json'
require_relative "./lib/libPStore.rb"
require_relative "lib/ServerConfig"
require_relative "lib/initConfig"
require_relative "lib/LibFRPC.rb"
require_relative "lib/LibRingBuffer"

$i=0
$sample={}


post '*' do

  obj=JSON.parse(params['data'])

  if obj["secret"] == ServerConfig.get("secret")
  	pass
  else
  	"nok"
  end
end


get '/hi' do

	ret = "hello"
end


###############################################
post '/metric' do
  
  obj=JSON.parse(params['data'])
  p obj

  if PS.get("p/"+obj["project"]+"/subids") != nil

    project =  obj["project"]

  	if $sample[project] == nil
      $sample[project] = {} # 
    end



    if $sample[project]["cpu"] == nil
      $sample[project]["cpu"] = RingBuffer.new(ServerConfig.get("sampleSize").to_i())
      $sample[project]["mem"] = RingBuffer.new(ServerConfig.get("sampleSize").to_i())
      $sample[project]["tcp"] = 0
      $sample[project]["udp"] = 0
    end

    str=File.read(ServerConfig.get("configLocation")+"/"+project+".config")
    obj=JSON.parse(str)

    $sample[project]["cpu"].push(obj["cpu"].to_i())
    cpu = $sample[project]["cpu"].inject(0,:+) / ServerConfig.get("sampleSize").to_i()
    $sample[project]["mem"].push(obj["mem"].to_i())
    mem = $sample[project]["mem"].inject(0,:+) / ServerConfig.get("sampleSize").to_i()
    $sample[project]["tcp"] = obj["tcp"]
    $sample[project]["tcp"] = obj["udp"]



    if cpu > obj["cpu"].to_i() || cpu > obj["mem"].to_i() || cpu > obj["tcp"].to_i() || cpu > obj["udp"].to_i()

        time = Time.now
        if PS.get("p/"+project+"/wait",time) <= time

            count = PS.get("p/"+project+"/required",0)
            count =count + 1

            if(count<=obj["maxInstances"].to_i())
              PS.set("p/"+project+"/required",count)
            end
        end

    end


  else
  	p "nay"

  end 



  $i=$i+1;
  ret = "ok"+$i.to_s()
end

#################################################

thr = Thread.new { 

  while true do

    FRPC.exec("channels/supervisor","counter_inc","web")

  sleep(2)

  end

}

def stop_server()

    abort("web terminated by supervisor.")

end