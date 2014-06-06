require 'spec_helper'

describe Bgg::Collection do
  let(:username) { "texasjdl" }
  let(:response_file) { "sample_data/collection?username=#{username}" }
  let(:request_url) { "http://www.boardgamegeek.com/xmlapi2/collection" }
  let(:query) { { username: username } }

  subject { Bgg::Collection.new(username) }

  it_behaves_like "a result"

  before do
    stub_request(:any, request_url).
      with(query: query).
      to_return(body: File.open(response_file), status: 200)
  end

  describe "enumerable" do
    its(:count) { should eq 15 }
    its(:first) { should be_instance_of Bgg::Collection::Item }
  end

  describe "#owned" do
    it { expect( subject.owned.count ).to eq 10 }
  end

  describe "#played" do
    it { expect( subject.played.count ).to eq 9 }
  end

  describe ".board_games" do
    let(:query) { { username: username, subtype: "boardgame", excludesubtype: "boardgameexpansion" } }

    it { expect( Bgg::Collection.board_games username ).to be_instance_of Bgg::Collection }
  end

  describe ".board_game_expansions" do
    let(:query) { { username: username, subtype: "boardgameexpansion" } }

    it { expect( Bgg::Collection.board_game_expansions username ).to be_instance_of Bgg::Collection }
  end

  describe ".rpgs" do
    let(:query) { { username: username, subtype: "rpgitem" } }

    it { expect( Bgg::Collection.rpgs username ).to be_instance_of Bgg::Collection }
  end

  describe ".video_games" do
    let(:query) { { username: username, subtype: "videogame" } }

    it { expect( Bgg::Collection.video_games username ).to be_instance_of Bgg::Collection }
  end
end
