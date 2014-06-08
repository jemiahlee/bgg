require 'spec_helper'

describe Bgg::Collection do
  let(:xml_string) { "
    <items>
      <item objectid='1'><name>1st</name><status own='1'/><numplays>1</numplays></item>
      <item objectid='2'><name>2nd</name><status own='0'/><numplays>0</numplays></item>
      <item objectid='3'><name>3rd</name><status own='1'/><numplays>0</numplays></item>
    </items>" }

  subject { Bgg::Collection.new(Nokogiri.XML xml_string) }

  it_behaves_like "a result"

  describe "enumerable" do
    its(:count) { should eq 3 }
    its(:first) { should be_instance_of Bgg::Collection::Item }
  end

  describe "#owned" do
    it { expect( subject.owned.count ).to eq 2 }
  end

  describe "#played" do
    it { expect( subject.played.count ).to eq 1 }
  end
end
