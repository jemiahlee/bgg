require 'spec_helper'

describe Bgg::Request::User do
  let(:query) { { name: username } }
  let(:params) { {} }
  let(:response_body) { '<?xml version="1.0" encoding="utf-8"?><user id="1"></user>' }
  let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/user' }
  let(:username) { 'abcdef' }

  subject { Bgg::Request::User.new username, params }

  before do
    stub_request(:any, request_url).
      with(query: query).
      to_return(body: response_body, status:200)
  end

  it { expect( subject ).to be_a Bgg::Request::Base }

  context 'throws an ArgumentError when username not present' do
    it do
      expect{ Bgg::Request::User.new nil }.to raise_error ArgumentError
      expect{ Bgg::Request::User.new '' }.to raise_error ArgumentError
    end
  end

  context 'class methods' do

    def class_method_helper
      expect( subject ).to be_instance_of Bgg::Request::User
      expect( subject.get ).to be_instance_of Bgg::Result::User
    end

    describe '.list_board_games' do
      let(:query) { { name: username, domain: 'boardgame', buddies: 1, guilds: 1, hot: 1, top: 1 } }

      subject { Bgg::Request::User.list_board_games username }

      it { class_method_helper }
    end

    describe '.list_rpgs' do
      let(:query) { { name: username, domain: 'rpg', buddies: 1, guilds: 1, hot: 1, top: 1 } }

      subject { Bgg::Request::User.list_rpgs username }

      it { class_method_helper }
    end

    describe '.list_video_games' do
      let(:query) { { name: username, domain: 'videogame', buddies: 1, guilds: 1, hot: 1, top: 1 } }

      subject { Bgg::Request::User.list_video_games username }

      it { class_method_helper }
    end
  end

  describe '#all_fields' do
    let(:query) { { name: username, buddies: 1, guilds: 1, hot: 1, top: 1 } }

    it do
      expect( subject.all_fields ).to be_instance_of Bgg::Request::User
      expect( subject.all_fields.get ).to be_instance_of Bgg::Result::User
    end
  end

  describe '#page' do
    let(:params) { { buddies: 1 } }
    let(:query) { { name: username, buddies: 1, page: 2 } }

    it do
      expect( subject.page(2) ).to be_instance_of Bgg::Request::User
      expect( subject.page(2).get ).to be_instance_of Bgg::Result::User
    end
  end
end
