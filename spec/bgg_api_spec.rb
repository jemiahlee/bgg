require 'spec_helper'

describe 'BggApi basic API calls' do
  context 'when calling an undefined method' do
    subject { BggApi.foo }

    it 'raises an UndefinedMethodError' do
      expect { subject }.to raise_error(NoMethodError)
    end
  end

  context 'when non-200 responses' do
    let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/search' }
    let(:expected_response) { '<?xml version="1.0" encoding="utf-8"?><items><item/><items>' }

    before do
      stub_request(:any, request_url)
        .with(query: query)
        .to_return(body: expected_response, status: 500)
    end

    describe 'BGG Search' do
      let(:query) { {query: 'Burgund', type: 'boardgame'} }
      it 'throws an error when non-200 response is received' do
        expect{BggApi.search(query)}.to raise_error
      end
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
      let(:item_id) { 7 }
      let(:username) { 'texasjdl' }
      let(:params) { {own: '1', type: 'boardgame'} }
      let(:query) { params.merge({ username: username }) }
      let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/collection' }
      let(:expected_response) { "<?xml version='1.0' encoding='utf-8'?><items><item objectid='#{item_id}'/><items>" }

      subject { BggApi.collection username, params }

      it { expect( subject ).to be_instance_of Bgg::Result::Collection }
      it { expect( subject.first.id ).to eq item_id }
    end

    describe 'BGG Family' do
      let(:type) { 'boardgamefamily' }
      let(:id) { 1234 }
      let(:query) { { id: id } }
      let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/family' }
      let(:expected_response) { "<?xml version='1.0' encoding='utf-8'?><items><item type='#{type}'/></items>" }

      subject { BggApi.family id }

      it { expect( subject ).to be_instance_of Bgg::Result::Family }
      it { expect( subject.type ).to eq type }
    end

    describe 'BGG Guild' do
      let(:name) { 'my_guild' }
      let(:id) { 1234 }
      let(:params) { { page: 2 } }
      let(:query) { params.merge({ id: id, members: 1 }) }
      let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/guild' }
      let(:expected_response) { "<?xml version='1.0' encoding='utf-8'?><guild name='#{name}'></guild>" }

      subject { BggApi.guild id, params }

      it { expect( subject ).to be_instance_of Bgg::Result::Guild }
      it { expect( subject.name ).to eq name }
    end

    describe 'BGG Hot Items' do
      let(:item_id) { 8 }
      let(:query) { {type: 'boardgame'} }
      let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/hot' }
      let(:expected_response) { "<?xml version='1.0' encoding='utf-8'?><items><item id='#{item_id}'/></items>" }

      subject { BggApi.hot query }

      it { expect( subject ).to be_instance_of Bgg::Result::Hot }
      it { expect( subject.first.id ).to eq item_id }
    end

    describe 'BGG Plays' do
      let(:count) { 10 }
      let(:thing_id) { 84876 }
      let(:username) { 'texasjd1' }
      let(:query) { { id: thing_id, username: username } }
      let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/plays' }
      let(:expected_response) { "<?xml version='1.0' encoding='utf-8'?><plays total='#{count}'><play/></plays>" }

      subject(:results) { BggApi.plays username, thing_id }

      it { expect( subject ).to be_instance_of Bgg::Result::Plays }
      it { expect( subject.total_count ).to eq count }
    end

    describe 'BGG Search' do
      let(:item_id) { 9 }
      let(:search) { 'Marvel' }
      let(:params) { { query: search } }
      let(:query) { params }
      let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/search' }
      let(:expected_response) { "<?xml version='1.0' encoding='utf-8'?><items><item id='#{item_id}'/></items>" }

      subject { BggApi.search search }

      it { expect( subject ).to be_instance_of Bgg::Result::Search }
      it { expect( subject.first.id ).to eq item_id }
    end

    describe 'BGG Thing' do
      let(:query) { {id: '84876', type: 'boardgame'} }
      let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/thing' }
      let(:response_file) { 'sample_data/thing?id=84876&type=boardgame' }

      subject(:results) { BggApi.thing(query) }

      it { should_not be_nil }

      it 'retrieves the correct id' do
        results['item'][0]['id'].should == '84876'
      end
    end

    describe 'BGG User' do
      let(:username) { 'texasjdl' }
      let(:query) { { name: username } }
      let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/user' }

      context 'who exists' do
        let(:expected_response) { '<?xml version="1.0" encoding="utf-8"?><user id="1"></user>' }

        subject { BggApi.user username }

        it { expect(subject).to be_instance_of Bgg::Result::User }
      end

      context 'who does not exist' do
        let(:expected_response) { '<?xml version="1.0" encoding="utf-8"?><user id=""></user>' }

        it { expect{ BggApi.user username }.to raise_error ArgumentError }
      end
    end
  end
end
