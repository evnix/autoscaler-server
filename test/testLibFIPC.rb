require_relative "../lib/LibFIPC.rb"

require 'test/unit'



class TestLibFIPC < Test::Unit::TestCase

	self.test_order = :defined

	def test_sendMsg()

		p "sending.."
		ret = FIPC.sendMsg("channels/1","hello_1")
		assert_equal(true,ret)
		ret = FIPC.sendMsg("channels/1","hello_2")
		assert_equal(true,ret)
		ret = FIPC.sendMsg("channels/1","hello_3")
		assert_equal(true,ret)	


	end

	def test_receiveMsg()

		p "receiving..."
		ret=FIPC.receiveMsg("channels/1")
		p ret
		assert_equal("hello_1",ret)
		ret=FIPC.receiveMsg("channels/1")
		p ret
		assert_equal("hello_2",ret)
		ret=FIPC.receiveMsg("channels/1")
		p ret
		assert_equal("hello_3",ret)
		#assert arr.length>0

	end


	def test_reset()

		ret = FIPC.sendMsg("channels/x","hello_1")
		ret = FIPC.reset("channels/x")
		assert_equal(true,ret)			

	end





end
