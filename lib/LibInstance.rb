


class BasicInstance

    @url
    @header
    @os
    @params


    def set_url(urlstr)

        @url = @url+urlstr
    end

    def get_url()

        return @url
    end


    def set_params(paramstr)

        @params=paramstr
    end

    def get_params()

       return @params
    end

    def set_header(key,val)
        @header[key]=val
    end

    def get_header(key)
        return @header[key]
    end

    def set_os(osstr)
        @os=osstr
    end


    def get_os()
        return @os
    end

    def initialize()
    @url=""
    @header={}
    @os=""
    @params=""
    end
    
    

end

class Decorator

    def initialize(obj)
        @obj = obj      
    end
    

end


class Vultr < Decorator


    
    def initialize(obj)
        super(obj)
        
    end


    def set_IPfetcher()

        @obj.set_url("https://api.vultr.com/v1/server/list")
        @obj.set_header("API-Key","34KSOMQICL5OCDFETXTV6AVZPYW3O4")

        return @obj
    end
    
    def set_data()
        @obj.set_url("https://api.vultr.com/v1/server/create")
        @obj.set_header("API-Key","34KSOMQICL5OCDFETXTV6AVZPYW3O4")

        if(@obj.get_os()=="ubuntu")
            @obj.set_params("DCID=8&VPSPLANID=29&OSID=160&SSHKEYID=57045f3be75c5")
        end

        return @obj

    end
    
end

class VM < Decorator

    def initialize(obj)
        super(obj)
        
    end


    def set_os(os)
        @obj.set_os(os)

        return @obj
    end
    
    def set_cost()
        @obj.cost+=200
    end
    
end




