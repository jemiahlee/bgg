require 'spec_helper'

shared_examples "a result" do
  it { expect( subject ).to respond_to :request, :xml }
  its(:request_params) { should be_a Hash }
end

shared_examples "a result container" do
  it_behaves_like "a result"

  its(:count) { should eq 2 }
  it { expect( subject.first ).to be_instance_of subject.class::Item }
end
