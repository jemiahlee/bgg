require 'spec_helper'

describe Bgg::Request::Collection do
  let(:username) { "abcdef" }
  let(:response_file) { "sample_data/collection?username=texasjdl" }
  let(:request_url) { "http://www.boardgamegeek.com/xmlapi2/collection" }
  let(:query) { { username: username } }

  subject { Bgg::Request::Collection.new username }

  before do
    stub_request(:any, request_url).
      with(query: query).
      to_return(body: File.open(response_file), status:200)
  end

  context 'throws an ArgumentError when username not present' do
    it do
      expect{ subject.get nil }.to raise_error ArgumentError
      expect{ subject.get '' }.to raise_error ArgumentError
    end
  end

  describe ".board_games" do
    let(:query) { { username: username, subtype: "boardgame", excludesubtype: "boardgameexpansion" } }

    it { expect( Bgg::Request::Collection.board_games username ).to be_instance_of Bgg::Collection }
  end

  describe ".board_game_expansions" do
    let(:query) { { username: username, subtype: "boardgameexpansion" } }

    it { expect( Bgg::Request::Collection.board_game_expansions username ).to be_instance_of Bgg::Collection }
  end

  describe ".rpgs" do
    let(:query) { { username: username, subtype: "rpgitem" } }

    it { expect( Bgg::Request::Collection.rpgs username ).to be_instance_of Bgg::Collection }
  end

  describe ".video_games" do
    let(:query) { { username: username, subtype: "videogame" } }

    it { expect( Bgg::Request::Collection.video_games username ).to be_instance_of Bgg::Collection }
  end
end
