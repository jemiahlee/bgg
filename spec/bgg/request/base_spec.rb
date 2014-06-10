require 'spec_helper'

describe Bgg::Request::Base do
  let(:status_code) { 200 }
  let(:request_url) { 'http://www.boardgamegeek.com/xmlapi2/collection?' }
  let(:response_body) { '<?xml version="1.0" encoding="utf-8"?><items><item/><items>' }
  let(:with) { {} }

  subject { Bgg::Request::Base.new :collection }

  before do
    stub_request(:any, request_url).
      with(with).
      to_return(body: response_body, status:status_code)
  end

  context 'invalid method argument' do
    it do
      expect{ Bgg::Request::Base.new nil }.to raise_error ArgumentError
      expect{ Bgg::Request::Base.new '' }.to raise_error ArgumentError
      expect{ Bgg::Request::Base.new :blah }.to raise_error ArgumentError
    end
  end

  context 'not 200 status' do
    let(:status_code) { 504 }

    it { expect{ subject.get }.to raise_error() }
  end

  context 'no params' do
    its(:params) { should eq({}) }
    its(:get) { should be_instance_of Bgg::Collection }
  end

  context 'with params' do
    let(:type) { { type: "boardgame" } }
    let(:with) { { query: type } }

    subject { Bgg::Request::Base.new :collection, type }

    its(:params) { should eq(type) }
    its(:get) { should be_instance_of Bgg::Collection }
  end

  describe '#add_params' do
    let(:param) { { add: "param" } }

    it { expect( subject.add_params param ).to eq param }
  end
end
