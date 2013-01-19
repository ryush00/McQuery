require 'helper'
require_relative '../lib/McQuery.rb'
class TestMcquery < Test::Unit::TestCase
	should "Not return nil for ping" do 
		assert_not_nil McQuery::Ping.new('localhost', 25565).doPing
	end
end
