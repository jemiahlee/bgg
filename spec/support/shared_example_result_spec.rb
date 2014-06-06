require 'spec_helper'

shared_examples "a result" do
  its(:xml) { should be_a Nokogiri::XML::Node }
end
