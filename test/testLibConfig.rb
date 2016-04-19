require_relative "../lib/LibConfig.rb"
require_relative "../lib/ServerConfig.rb"
require_relative "../lib/initConfig.rb"
require 'test/unit'



class TestLibConfig < Test::Unit::TestCase

	def test_listConfigs()

		lc = LibConfig.new()
		arr=LibConfig._listConfigs()
		assert arr.length>0


	end


	def test_getRepoConfig()

		lc = LibConfig.new()
		obj=LibConfig._getRepoConfig("/home/silva/test/autoscaler-server/test/data/mock-syndev.config")
		assert_equal("syndev",obj['repoDir'])

	end


end



