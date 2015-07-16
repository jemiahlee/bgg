# encoding: UTF-8
require 'spec_helper'

describe Bgg::Stats do
  let(:stats_data) { {"usersrated"    => [{"value" => "19609"}],
                     "average"       => [{"value" => "8.33854"}],
                     "bayesaverage"  => [{"value" => "8.22232"}],
                     "ranks"         =>
                         [{"rank" =>
                               [{"type"         => "subtype",
                                 "id"           => "1",
                                 "name"         => "boardgame",
                                 "friendlyname" => "Board Game Rank",
                                 "value"        => "1",
                                 "bayesaverage" => "8.22232"},
                                {"type"         => "family",
                                 "id"           => "4664",
                                 "name"         => "wargames",
                                 "friendlyname" => "War Game Rank",
                                 "value"        => "1",
                                 "bayesaverage" => "8.30721"},
                                {"type"         => "family",
                                 "id"           => "5497",
                                 "name"         => "strategygames",
                                 "friendlyname" => "Strategy Game Rank",
                                 "value"        => "1",
                                 "bayesaverage" => "8.20911"}]}],
                     "stddev"        => [{"value" => "1.5959"}],
                     "median"        => [{"value" => "0"}],
                     "owned"         => [{"value" => "26026"}],
                     "trading"       => [{"value" => "367"}],
                     "wanting"       => [{"value" => "1173"}],
                     "wishing"       => [{"value" => "5691"}],
                     "numcomments"   => [{"value" => "5256"}],
                     "numweights"    => [{"value" => "2516"}],
                     "averageweight" => [{"value" => "3.4769"}]}
  }


  describe 'instance' do
    let(:stats_obj) { described_class.new(stats_data) }

    all_attrs = [
        [:average, BigDecimal.new('8.33854')],
        [:averageweight, BigDecimal.new('3.4769')],
        [:bayesaverage, BigDecimal.new('8.22232')],
        [:median, BigDecimal.new(0)],
        [:numcomments, 5256],
        [:numweights, 2516],
        [:owned, 26026],
        [:stddev, BigDecimal.new('1.5959')],
        [:trading, 367],
        [:usersrated, 19609],
        [:wanting, 1173],
        [:wishing, 5691],
    ]

    shared_examples "a stats attribute" do |attr, expected_val|
      describe ".#{attr}" do
        it 'exists' do
          expect(stats_obj).to respond_to(attr)
        end
        it 'returns the attrs value' do
          expect(stats_obj.send(attr)).to eq(expected_val)
        end
      end
    end

    all_attrs.each do |attr, expected_val|
      it_should_behave_like 'a stats attribute', attr, expected_val
    end

    describe '.ranks' do
      it 'exists' do
        expect(stats_obj).to respond_to(:ranks)
      end

      it 'returns an array of game_rank_objects' do
        expect(stats_obj.ranks).to be_a Array
        expect(stats_obj.ranks.length).to eq 3
        expect(stats_obj.ranks.all?{|i| i.is_a? Bgg::GameRank}).to be_true
      end

    end
  end
end
