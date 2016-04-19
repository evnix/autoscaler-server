require_relative "../lib/LibUpdater.rb"
require_relative "../lib/ServerConfig.rb"
require_relative "../lib/initConfig.rb"
require 'test/unit'



class TestLibUP < Test::Unit::TestCase

	def test_update()

	cu = LibUpdater.new()
	puts "CU: "
	r= cu.updateRepos()
	assert_equal(true,r)
	end

	#check to see if files are not overwritten
	def test_noUpdate()

	cu = LibUpdater.new()
	puts "CU: "
	r= cu.updateRepos()
	assert_equal(true,r)
	end


end



