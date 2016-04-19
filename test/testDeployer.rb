require_relative "../lib/LibDeployer.rb"
require_relative "../lib/ServerConfig.rb"
require_relative "../lib/initConfig.rb"
require 'test/unit'



class TestLibDP < Test::Unit::TestCase

	def test_deploy()

		dp= LibDeployer.new()
	
			result=dp.deploy()
			assert_equal(true,result)



	end


	def test_getRepoConfig()

		dp= LibDeployer.new()
	
			result=dp.listRepos()
			assert result.length > 0

	end


end



