require_relative "../lib/LibInstanceCreator.rb"
require_relative "../lib/ServerConfig.rb"
require_relative "../lib/initConfig.rb"
require 'test/unit'



class TestLibIC < Test::Unit::TestCase

	def test_create()

	ic= LibInstanceCreator.new()
    res= ic.createInstances()
    assert res.length > 0

	end

	#should not create
	def test_create_twice()

	ic= LibInstanceCreator.new()
    res= ic.createInstances()
    assert res.length > 0

	end


	#should not create
	def test_create_thrice()

	ic= LibInstanceCreator.new()
    res= ic.createInstances()
    assert res.length > 0

	end
end



