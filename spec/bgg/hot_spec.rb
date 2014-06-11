require 'spec_helper'

describe Bgg::Hot do
  let(:request) { double('Bgg::Request::Hot') }
  let(:xml_string) { "<items><item id='1'></item><item id='2'></item></items>" }
  let(:params) { {} }
  subject { Bgg::Hot.new(Nokogiri.XML(xml_string), request) }

  before do
    request.stub(:params).and_return( params )
  end

  it_behaves_like "a result"

  describe "enumerable" do
    its(:count) { should eq 2 }
    its(:first) { should be_a Bgg::Hot::Item }
  end

  context 'with no type request param set' do
    its(:type) { should eq 'boardgame' }
  end

  context 'with type request param set' do
    let(:type)   { 'abc' }
    let(:params) { { type: type } }

    its(:type) { should eq type }
  end
end
