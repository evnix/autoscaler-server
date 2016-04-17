require 'sinatra'
require 'json'
require_relative "./lib/libPStore.rb"
require_relative "lib/ServerConfig"
require_relative "lib/initConfig"
require_relative "lib/LibFRPC.rb"
require_relative "lib/LibRingBuffer"
require 'digest/sha2'
enable :sessions

set :bind, '0.0.0.0'
set :port, 80

$i=0
$sample={}



post '/login' do
  #pass@989..
   obj ={}
  if param['p']!=nil &&  ServerConfig.get("pass") == Digest::SHA2.hexdigest(params['p']+ServerConfig.get("salt"))
      t="ok"
      session['token'] = rand(999..9999).to_s()+"xq"
      
     
      obj['token'] =session['token']
      obj['res'] ='ok'
  else
     obj['res'] ='nok'
  end

  JSON.generate(obj)
end


get '/webui' do

  File.read("app/view/file.html")

end

post '/metri*' do



  if params['data'] == nil
 
    return "noAuth"
  end

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
    sobj=JSON.parse(str)

   cpu = $sample[project]["cpu"].inject(0,:+) / ServerConfig.get("sampleSize").to_i()
    $sample[project]["mem"].push(obj["mem"].to_i())
    mem = $sample[project]["mem"].inject(0,:+) / ServerConfig.get("sampleSize").to_i()
    $sample[project]["tcp"] =obj["tcp"]
    $sample[project]["udp"] = obj["udp"]


p $sample[project]["udp"].to_i() > sobj["udp"].to_i()
p sobj["udp"].to_i()
    if cpu > sobj["cpu"].to_i() || mem > sobj["mem"].to_i() || $sample[project]["tcp"].to_i() > sobj["tcp"].to_i() || $sample[project]["udp"].to_i() > sobj["udp"].to_i()


        time = Time.now
        if PS.get("p/"+project+"/wait",time) <= time

            count = PS.get("p/"+project+"/required",0)
            count =count + 1

            if(count<=sobj["maxInstances"].to_i())
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