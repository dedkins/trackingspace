require 'spec_helper'

describe Micropost do

	before(:each) do
		@attr = {
			:content => "Value for Content",
			:user_id => 1
		}
	end

	it "should create a new instance given the valid attributes" do
		Micropost.create!(@attr)
	end
	
end
