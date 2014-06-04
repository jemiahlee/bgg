require 'spec_helper'

describe Bgg::Request::Collection do
  subject { Bgg::Request::Collection }

  describe '.request' do
    it 'throws an ArgumentError when username not present' do
      expect{ subject.request nil }.to raise_error(ArgumentError)
      expect{ subject.request '' }.to raise_error(ArgumentError)
    end

    describe 'makes a request if username is valid' do
      let(:username) { "abcdef" }
      let(:response_file) { "sample_data/collection?username=texasjdl" }
      let(:request_url) { "http://www.boardgamegeek.com/xmlapi2/collection" }

      before do
        stub_request(:any, request_url).
          with(query: {username: username}).
          to_return(body: File.open(response_file), status:200)
      end

      it { expect( subject.request username ).to be_a_kind_of(Nokogiri::XML::Document) }
    end
  end
end
