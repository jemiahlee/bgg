require 'spec_helper'

describe BggRequest do

end
describe 'BggApi basic API calls' do
  context 'when calling an undefined method' do
    subject { BggRequest.foo }

    it 'raises an UndefinedMethodError' do
      expect { subject }.to raise_error(NoMethodError)
    end
  end

  context 'with stubbed responses' do
    let(:expected_response) { File.open(response_file) }

    before do
      stub_request(:any, request_url)
        .with(query: query)
        .to_return(body: expected_response, status: 200)
    end

    describe 'BGG Collection' do
      let(:username) { 'texasjdl' }
      let(:params) { {own: '1', type: 'boardgame'} }
      let(:query) { params.merge({ username: username }) }
      let(:request_url) { 'http://www.boardgamegeek.com/xmlapi2/collection' }
      let(:response_file) { 'sample_data/collection?username=texasjdl&own=1&excludesubtype=boardgameexpansion' }

      subject(:results) { BggRequest.collection username, params }

      it { expect( subject ).to be_instance_of Bgg::Collection }
    end
  end
end
