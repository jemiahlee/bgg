require 'spec_helper'

shared_examples "a result" do
  it { expect( subject ).to respond_to :request, :xml }
  its(:request_params) { should be_a Hash }
end
