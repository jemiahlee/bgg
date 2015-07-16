# encoding: UTF-8
require 'spec_helper'

describe Bgg::Link do
  let(:link_data) { [{"type" => "boardgamecategory", "id" => "1002", "value" => "Card Game"},
                     {"type" => "boardgamemechanic", "id" => "2664", "value" => "Deck / Pool Building"},
                     {"type" => "boardgamefamily", "id" => "5427", "value" => "DC Universe"},
  ] }

  describe 'class method' do
  end

  describe 'instance' do
    let(:card_game) { described_class.new(link_data.last) }
    describe '.id' do
      it 'exists' do
        expect(card_game).to respond_to(:id)
      end
      it 'returns the BGG Thing id' do
        expect(card_game.id).to eq(5427)
      end
    end

    describe '.value' do
      it 'exists' do
        expect(card_game).to respond_to(:value)
      end

      it 'returns the value' do
        expect(card_game.value).to eq('DC Universe')
      end
    end

    describe '.bgg_type' do
      it 'exists' do
        expect(card_game).to respond_to(:bgg_type)
      end

      it 'returns the gbb_type' do
        expect(card_game.bgg_type).to eq('family')
      end
    end

  end
end
