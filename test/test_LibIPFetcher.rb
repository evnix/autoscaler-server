require_relative "../lib/LibIPFetcher.rb"
require_relative "../lib/ServerConfig.rb"
require_relative "../lib/initConfig.rb"
require 'test/unit'



class TestLibConfig < Test::Unit::TestCase

	def test_fetch()

	ift= LibIPFetcher.new()
	p "IP-F1"
   	res= ift.fetchIPs()
  	p res
    #FRPC.run(FRPC.receiveMsg("channels/IPFetcher"))
    assert res.length > 0

	end

	def test_fetch2()

	ift= LibIPFetcher.new()
	p "IP-F2"
   	res= ift.fetchIPs()
  	p res
    #FRPC.run(FRPC.receiveMsg("channels/IPFetcher"))
    assert res.length > 0

	end

	def test_fetch3()

	ift= LibIPFetcher.new()
	p "IP-F3"
   	res= ift.fetchIPs()
  	p res
    #FRPC.run(FRPC.receiveMsg("channels/IPFetcher"))
    assert res.length > 0

	end



end



