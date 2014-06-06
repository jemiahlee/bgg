# encoding: UTF-8
require 'spec_helper'

describe Bgg::Collection::Item do
  let(:item_xml) { Nokogiri.XML(xml_string) }
  let(:xml_string) { "<items><item/></items>" }

  subject { Bgg::Collection::Item.new(item_xml.at_xpath("items/item")) }

  it_behaves_like "a result"

  context 'without data' do
    its(:id)             { should eq(nil) }
    its(:type)           { should eq(nil) }
    its(:collection_id)  { should eq(nil) }
    its(:name)           { should eq(nil) }
    its(:year_published) { should eq(nil) }
    its(:image)          { should eq(nil) }
    its(:thumbnail)      { should eq(nil) }
    its(:players)        { should eq(nil) }
    its(:play_time)      { should eq(nil) }
    its(:own_count)      { should eq(nil) }
    its(:user_rating)    { should eq(nil) }
    its(:average_rating) { should eq(nil) }
    its(:bgg_rating)     { should eq(nil) }
    its(:type_rank)      { should eq(nil) }
    its(:theme_ranks)    { should eq(nil) }
    its(:last_modified)  { should eq(nil) }
    its(:play_count)     { should eq(nil) }
    its(:comment)        { should eq(nil) }
    its(:owned?)         { should eq(nil) }
    its(:wanted?)        { should eq(nil) }
    its(:for_trade?)     { should eq(nil) }
    its(:played?)        { should eq(nil) }
    its(:want_to_buy?)   { should eq(nil) }
    its(:preordered?)    { should eq(nil) }
    its(:want_to_play?)  { should eq(nil) }
    its(:published?)     { should eq(nil) }
  end

  context 'with data' do
    let(:id) { 1234 }
    let(:type) { 'abc' }
    let(:collection_id) { 5678 }
    let(:name) { 'defg' }
    let(:year_published) { 2014 }
    let(:image) { 'hijk' }
    let(:thumbnail) { 'lmno' }
    let(:min_players) { 2 }
    let(:max_players) { 4 }
    let(:play_time) { 120 }
    let(:own_count) { 123456 }
    let(:user_rating) { 9.5 }
    let(:average_rating) { 7.63834 }
    let(:bgg_rating) { 7.34567 }
    let(:type_rank) { 987 }
    let(:theme_ranks) { [ { id: 654, title: "Family", rank: 32, rating: 7.54321 },
                          { id: 543, title: "Name", rank: 43, rating: 7.21098 } ] }
    let(:last_modified) { Time.new("2001-01-01") }
    let(:status) { 1 }
    let(:play_count) { 2 }
    let(:comment) { 'p' }
    let(:xml_string) { "
      <items>
        <item objectid='#{id}' subtype='#{type}' collid='#{collection_id}'>
          <name>#{name}</name>
          <yearpublished>#{year_published}</yearpublished>
          <image>#{image}</image>
          <thumbnail>#{thumbnail}</thumbnail>
          <stats minplayers='#{min_players}'
                 maxplayers='#{max_players}'
                 playingtime='#{play_time}'
                 numowned='#{own_count}'>
            <rating value='#{user_rating}'>
              <average value='#{average_rating}'/>
              <bayesaverage value='#{bgg_rating}'/>
              <ranks>
                <rank type='subtype' value='#{type_rank}'/>
                <rank type='family'
                      id='#{theme_ranks.first[:id]}'
                      friendlyname='#{theme_ranks.first[:title]}'
                      value='#{theme_ranks.first[:rank]}'
                      bayesaverage='#{theme_ranks.first[:rating]}'/>
                <rank type='family'
                      id='#{theme_ranks.last[:id]}'
                      friendlyname='#{theme_ranks.last[:title]}'
                      value='#{theme_ranks.last[:rank]}'
                      bayesaverage='#{theme_ranks.last[:rating]}'/>
              </ranks>
            </rating>
          </stats>
          <status own='#{status}'
                  prevowned='#{status}'
                  fortrade='#{status}'
                  want='#{status}'
                  wanttoplay='#{status}'
                  wanttobuy='#{status}'
                  wishlist='#{status}'
                  preordered='#{status}'
                  lastmodified='#{last_modified}'/>
          <numplays>#{play_count}</numplays>
          <comment>#{comment}</comment>
        </item>
      </items>" }

    its(:id)             { should eq(id) }
    its(:type)           { should eq(type) }
    its(:collection_id)  { should eq(collection_id) }
    its(:name)           { should eq(name) }
    its(:year_published) { should eq(year_published) }
    its(:image)          { should eq(image) }
    its(:thumbnail)      { should eq(thumbnail) }
    its(:players)        { should eq(min_players..max_players) }
    its(:play_time)      { should eq(play_time) }
    its(:own_count)      { should eq(own_count) }
    its(:user_rating)    { should eq(user_rating) }
    its(:average_rating) { should eq(average_rating) }
    its(:bgg_rating)     { should eq(bgg_rating) }
    its(:type_rank)      { should eq(type_rank) }
    its(:theme_ranks)    { should eq(theme_ranks) }
    its(:last_modified)  { should eq(last_modified) }
    its(:play_count)     { should eq(play_count) }
    its(:comment)        { should eq(comment) }

    context 'booleans true' do
      let(:status)         { 1 }
      let(:play_count)     { 1 }
      let(:year_published) { 2014 }

      its(:owned?)         { should eq(true) }
      its(:wanted?)        { should eq(true) }
      its(:for_trade?)     { should eq(true) }
      its(:played?)        { should eq(true) }
      its(:want_to_buy?)   { should eq(true) }
      its(:preordered?)    { should eq(true) }
      its(:want_to_play?)  { should eq(true) }
      its(:published?)     { should eq(true) }
    end

    context 'booleans false' do
      let(:status)     { 0 }
      let(:play_count) { 0 }
      let(:year_published) { 0 }

      its(:owned?)         { should eq(false) }
      its(:wanted?)        { should eq(false) }
      its(:for_trade?)     { should eq(false) }
      its(:played?)        { should eq(false) }
      its(:want_to_buy?)   { should eq(false) }
      its(:preordered?)    { should eq(false) }
      its(:want_to_play?)  { should eq(false) }
      its(:published?)     { should eq(false) }
    end

  end

  #describe '#game' do
    #it 'exists' do
      #expect( item ).to respond_to(:game)
    #end

    #it 'returns a Bgg::Game object corresponding to the entry' do
      #response_file = 'sample_data/thing?id=70512&type=boardgame'
      #request_url = 'http://www.boardgamegeek.com/xmlapi2/thing'

      #stub_request(:any, request_url).
        #with(query: {id: 70512, type: 'boardgame'}).
        #to_return(body: File.open(response_file), status: 200)

      #game = item.game

      #expect( game ).to be_instance_of(Bgg::Game)
      #expect( game.name ).to eq('Luna')
      #expect( game.designers ).to eq(['Stefan Feld'])
    #end
  #end
end
