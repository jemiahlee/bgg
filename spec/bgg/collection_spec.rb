require 'spec_helper'

describe Bgg::Collection do
  let(:item1_data) { nil }
  let(:item2_data) { nil }
  let(:item3) { nil }
  let(:request) { double('Bgg::Request::Collection') }
  let(:xml_string) { "
    <items>
      <item objectid='1'>#{item1_data}</item>
      <item objectid='2'>#{item2_data}</item>
      #{item3}
    </items>" }
  subject { Bgg::Collection.new(Nokogiri.XML(xml_string), request) }

  before do
    request.stub(:params).and_return( { username: 'username' } )
  end

  it_behaves_like "a result"

  describe "enumerable" do
    its(:count) { should eq 2 }
    its(:first) { should be_instance_of Bgg::Collection::Item }
  end

  describe "#owned" do
    let(:item1_data) { "<status own='1'/>" }
    let(:item2_data) { "<status own='0'/>" }

    it { expect( subject.owned.count ).to eq 1 }
  end

  describe "#played" do
    let(:item1_data) { "<numplays>1</numplays>" }
    let(:item2_data) { "<numplays>0</numplays>" }

    it { expect( subject.played.count ).to eq 1 }
  end

  describe "#user_rated" do
    let(:item1_data) { "<stats><rating value='5'/></stats>" }
    let(:item2_data) { "<stats><rating value='8'/></stats>" }
    let(:item3) { "<item objectid='3'><stats><rating value='N/A'/></stats></item>" }

    before do
      request.stub(:params).and_return( { username: 'username', stats: 1 } )
    end

    it do
      expect( subject.user_rated.count ).to eq 2
      expect( subject.user_rated(5).count ).to eq 1
      expect( subject.user_rated(5..8).count ).to eq 2
      expect( subject.user_rated(1..4).count ).to eq 0
    end
  end
end
