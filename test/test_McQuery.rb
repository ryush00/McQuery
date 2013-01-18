require 'helper'
require_relative '../lib/McQuery.rb'
class TestMcquery < Test::Unit::TestCase
	should "Not return nil for query" do 
		assert_not_nil McQuery::Query.new('localhost', 25565).doQuery
	end
end
