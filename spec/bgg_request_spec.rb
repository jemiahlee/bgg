require 'spec_helper'

describe BggRequest do
  context 'when calling an undefined method' do
    subject { BggRequest.foo }

    it 'raises an UndefinedMethodError' do
      expect { subject }.to raise_error(NoMethodError)
    end
  end

  context 'with stubbed responses' do
    let(:response_body) { '<?xml version="1.0" encoding="utf-8"?><items><item/><items>' }

    before do
      stub_request(:any, request_url)
        .with(query: with)
        .to_return(body: response_body, status: 200)
    end

    describe 'BGG Collection' do
      let(:username) { 'texasjdl' }
      let(:params) { {own: '1', type: 'boardgame'} }
      let(:with) { params.merge({ username: username }) }
      let(:request_url) { 'http://www.boardgamegeek.com/xmlapi2/collection' }

      subject { BggRequest.collection username, params }

      it { expect( subject ).to be_instance_of Bgg::Collection }
    end

    describe 'BGG Search' do
      let(:query) { 'Marvel' }
      let(:params) { { query: query } }
      let(:with) { params }
      let(:request_url) { 'http://www.boardgamegeek.com/xmlapi2/search' }

      subject { BggRequest.search query, params }

      it { expect( subject ).to be_instance_of Bgg::Search }
    end
  end
end
