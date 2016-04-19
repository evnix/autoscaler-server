
require_relative "../lib/LibFRPC.rb"

require 'test/unit'



def say_hello(x,y)

	p "Hello"
	p x
	p y

end

class TestLibFRPC < Test::Unit::TestCase

	self.test_order = :defined

	def test_exec()

		ret = FRPC.exec("channels/0","say_hello","aaa","bbb")
		assert_equal(true,ret)

	end


	def test_run()

		ret = FRPC.run(FRPC.receiveMsg("channels/0"))
		assert_equal(true,ret)

	end





end
