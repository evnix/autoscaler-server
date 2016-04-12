require_relative "lib/LibFRPC.rb"


$jobs = ["configLoader"]


$counters={}


def counter_inc(key)


  if $counters[key] == nil
    $counters[key] = 3
    return true
  end

  $counters[key]=$counters[key]+1;

end


def counter_dec(key)


  if $counters[key] == nil
    $counters[key] = 3
  end

  if $counters[key] == 0
    
      start_job(key)

  end

  $counters[key]=$counters[key]-1;

end


def dec_all()

      $jobs.each {

        |job|
        
        counter_dec(job)

    }

end



def start_job(job)
   
    job1 = fork do
        exec "ruby "+job+".rb"
    end
    
    Process.detach(job1)

end




def stop_job(job)

    		FRPC.exec("channels/"+job,"stop_server")

end

def start_all()

    $jobs.each {

        |job|
        
        start_job(job)

    }

end


def stop_all()

      $jobs.each {

        |job|
        
        stop_job(job)

    }

end 



start_all()


loop do 
  # some code here
  

  dec_all()
  FRPC.run(FRPC.receiveMsg("channels/supervisor"))


  p $counters
  sleep(2)
  break if false
end 
