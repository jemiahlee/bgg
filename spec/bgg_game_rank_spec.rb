# encoding: UTF-8
require 'spec_helper'

describe Bgg::GameRank do
  let(:game_rank_data) { {"type"         => "subtype",
                          "id"           => "1",
                          "name"         => "boardgame",
                          "friendlyname" => "Board Game Rank",
                          "value"        => "1",
                          "bayesaverage" => "8.22232"} }

  describe 'class method' do
  end

  describe 'instance' do

    let(:game_rank_obj) { described_class.new(game_rank_data) }

    all_attrs = [
        [:type, "subtype"],
        [:id, 1],
        [:name, "boardgame"],
        [:friendlyname, "Board Game Rank"],
        [:value, 1],
        [:bayesaverage, BigDecimal.new("8.22232")],
    ]

    shared_examples "a game_rank attribute" do |attr, expected_val|
      describe ".#{attr}" do
        it 'exists' do
          expect(game_rank_obj).to respond_to(attr)
        end
        it 'returns the attrs value' do
          expect(game_rank_obj.send(attr)).to eq(expected_val)
        end
      end
    end

    all_attrs.each do |attr, expected_val|
      it_should_behave_like 'a game_rank attribute', attr, expected_val
    end

  end
end
