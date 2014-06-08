require 'spec_helper'

shared_examples "a result" do
  its(:xml) { should be_a Nokogiri::XML::Node }
  its(:request) { should be_a Bgg::Request::Base }
  its(:request_params) { should be_a Hash }
end
