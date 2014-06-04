require 'spec_helper'

describe Bgg::Request::Base do
  subject { Bgg::Request::Base }

  describe '.request' do

    it 'throws an ArgumentError when method is not known' do
      expect{ subject.request nil }.to raise_error(ArgumentError)
      expect{ subject.request '' }.to raise_error(ArgumentError)
      expect{ subject.request :blah }.to raise_error(ArgumentError)
    end

    it 'makes a request if method is valid but server is down' do
      request_url = 'http://www.boardgamegeek.com/xmlapi2/hot?'

      stub_request(:any, request_url).with().to_return(status:504)

      expect{ subject.request :blah }.to raise_error()
    end

    describe 'valid method' do
      let(:response_file) { 'sample_data/hot?type=boardgame' }
      let(:request_url) { 'http://www.boardgamegeek.com/xmlapi2/hot?' }

      before do
        stub_request(:any, request_url).with(with).to_return(body: File.open(response_file), status:200)
      end

      context 'no params' do
        let(:with) { {} }

        it { expect( subject.request :hot ).to be_a_kind_of(Nokogiri::XML::Document) }
      end

      context 'with params' do
        let(:type) { { type: "boardgame" } }
        let(:with) { { query: type } }

        it { expect( subject.request :hot, type ).to be_a_kind_of(Nokogiri::XML::Document) }
      end
    end

  end
end
