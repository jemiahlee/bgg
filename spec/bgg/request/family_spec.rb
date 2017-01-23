require 'spec_helper'

describe Bgg::Request::Family do
  let(:query) { {} }
  let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/family' }
  let(:response_body) { '<?xml version="1.0" encoding="utf-8"?><items><item/></items>' }

  subject { Bgg::Request::Family.new id }

  before do
    stub_request(:any, request_url).
      with(query: query).
      to_return(body: response_body, status:200)
  end

  describe '.new' do
    let(:id) { nil }

    context 'throws an ArgumentError when id is not present' do
      it do
        expect{ Bgg::Request::Family.new nil }.to raise_error ArgumentError
        expect{ Bgg::Request::Family.new '' }.to raise_error ArgumentError
      end
    end

    context 'valid id' do
      let(:id) { 1234 }
      let(:query) { { id: id } }

      it do
        expect( subject ).to be_instance_of Bgg::Request::Family
        expect( subject.get ).to be_instance_of Bgg::Result::Family
      end
    end
  end
end
