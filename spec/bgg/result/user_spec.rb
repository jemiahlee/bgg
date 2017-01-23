require 'spec_helper'

describe Bgg::Result::User do
  let(:item_xml) { Nokogiri.XML("<?xml version='1.0' encoding='utf-8'?>#{xml_string}") }
  let(:params) { {} }
  let(:request) { double('Bgg::Request::User') }

  before do
    request.stub(:params).and_return(params)
  end

  context 'invalid user' do
    let(:xml_string) { '<user></user>' }

    it 'throws an error' do
      expect{ Bgg::Result::User.new(item_xml, request) }.to  raise_error ArgumentError
    end

  end

  context 'without data' do
    let(:xml_string) { '<user id="1"></user>' }

    subject { Bgg::Result::User.new(item_xml, request) }

    its(:avatar_link)        { should eq nil }
    its(:battle_net_account) { should eq nil }
    its(:buddies)            { should eq [] }
    its(:buddy_count)        { should eq nil }
    its(:buddy_page)         { should eq nil }
    its(:country)            { should eq nil }
    its(:first_name)         { should eq nil }
    its(:guild_count)        { should eq nil }
    its(:guild_names)        { should eq [] }
    its(:guild_page)         { should eq nil }
    its(:guilds)             { should eq [] }
    its(:hot)                { should eq [] }
    its(:id)                 { should eq 1 }
    its(:last_login)         { should eq nil }
    its(:last_name)          { should eq nil }
    its(:psn_account)        { should eq nil }
    its(:state)              { should eq nil }
    its(:steam_account)      { should eq nil }
    its(:top)                { should eq [] }
    its(:trade_rating)       { should eq nil }
    its(:username)           { should eq nil }
    its(:year_registered)    { should eq nil }
    its(:web_address)        { should eq nil }
    its(:wii_account)        { should eq nil }
    its(:xbox_account)       { should eq nil }
  end

  context 'with data' do
    let(:avatar_link)        { 'avatar_link' }
    let(:battle_net_account) { 'battle_net' }
    let(:buddy)              { 'buddy' }
    let(:buddy_id)           { 1234 }
    let(:buddy_count)        { 1 }
    let(:country)            { 'country' }
    let(:domain)             { 'boardgame' }
    let(:first_name)         { 'first_name' }
    let(:guild)              { 'guild' }
    let(:guild_count)        { 1 }
    let(:guild_id)           { 234 }
    let(:hot_id)             { 1 }
    let(:hot_name)           { 'hot' }
    let(:hot_rank)           { 1 }
    let(:hot_type)           { 'type' }
    let(:id)                 { 1 }
    let(:last_login_date)    { Date.new(2001, 1, 1) }
    let(:last_login)         { last_login_date.strftime('%F') }
    let(:last_name)          { 'last_name' }
    let(:page)               { 1 }
    let(:psn_account)        { 'psn' }
    let(:state)              { 'state' }
    let(:steam_account)      { 'steam' }
    let(:top_id)             { 1 }
    let(:top_name)           { 'top' }
    let(:top_rank)           { 1 }
    let(:top_type)           { 'type' }
    let(:trade_rating)       { 1 }
    let(:username)           { 'username' }
    let(:year_registered)    { 2001 }
    let(:web_address)        { 'web' }
    let(:wii_account)        { 'wii' }
    let(:xbox_account)       { 'xbox' }

    let(:params)         { { name: username } }
    let(:xml_string) {"<user id='#{id}' name='#{username}'>
                         <firstname value='#{first_name}'/>
                         <lastname value='#{last_name}'/>
                         <avatarlink value='#{avatar_link}'/>
                         <yearregistered value='#{year_registered}'/>
                         <lastlogin value='#{last_login}'/>
                         <stateorprovince value='#{state}'/>
                         <country value='#{country}'/>
                         <webaddress value='#{web_address}'/>
                         <xboxaccount value='#{xbox_account}'/>
                         <wiiaccount value='#{wii_account}'/>
                         <psnaccount value='#{psn_account}'/>
                         <battlenetaccount value='#{battle_net_account}'/>
                         <steamaccount value='#{steam_account}'/>
                         <traderating value='#{trade_rating}'/>
                         <buddies total='#{buddy_count}' page='#{page}'>
                           <buddy id='#{buddy_id}' name='#{buddy}'/>
                         </buddies>
                         <guilds total='#{guild_count}' page='#{page}'>
                           <guild id='#{guild_id}' name='#{guild}'/>
                         </guilds>
                         <top domain='#{domain}'>
                           <item rank='#{top_rank}' type='#{top_type}' id='#{top_id}' name='#{top_name}'/>
                         </top>
                         <hot domain='#{domain}'>
                           <item rank='#{hot_rank}' type='#{hot_type}' id='#{hot_id}' name='#{hot_name}'/>
                         </hot>
                       </user>"}

    subject { Bgg::Result::User.new(item_xml, request) }

    its(:avatar_link)        { should eq avatar_link }
    its(:battle_net_account) { should eq battle_net_account }
    its(:buddies)            { should eq [buddy] }
    its(:buddy_count)        { should eq buddy_count }
    its(:buddy_page)         { should eq page }
    its(:country)            { should eq country }
    its(:first_name)         { should eq first_name }
    its(:guild_count)        { should eq guild_count }
    its(:guild_names)        { should eq [guild] }
    its(:guild_page)         { should eq page }
    its(:guilds)             { should eq [{ id: guild_id, name: guild }] }
    its(:hot)                { should eq [{ id: hot_id, name: hot_name, type: hot_type, rank: hot_rank }] }
    its(:id)                 { should eq id }
    its(:last_login)         { should eq last_login_date }
    its(:last_name)          { should eq last_name }
    its(:psn_account)        { should eq psn_account }
    its(:state)              { should eq state }
    its(:steam_account)      { should eq steam_account }
    its(:top)                { should eq [{ id: top_id, name: top_name, type: top_type, rank: top_rank }] }
    its(:trade_rating)       { should eq trade_rating }
    its(:username)           { should eq username }
    its(:year_registered)    { should eq year_registered }
    its(:web_address)        { should eq web_address }
    its(:wii_account)        { should eq wii_account }
    its(:xbox_account)       { should eq xbox_account }
  end

  context 'secondary fetches of data' do
    let(:username)   { 'username' }
    let(:params)     { { name: username } }
    let(:xml_string) { '<user id="1"><buddies/><guilds/><top/><hot/></user>' }

    subject { Bgg::Result::User.new(item_xml, request) }

    before do
      stub_request(:any, request_url).
        with(query: { username: username }).
        to_return(body: response_body, status:200)
    end

    context 'plays' do
      let(:response_body) { '<?xml version="1.0" encoding="utf-8"?><plays><play/><plays>' }
      let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/plays' }

      its(:plays)      { should be_a_kind_of(Bgg::Result::Plays) }
    end

    context 'plays' do
      let(:response_body) { '<?xml version="1.0" encoding="utf-8"?><items><item/><items>' }
      let(:request_url) { 'https://www.boardgamegeek.com/xmlapi2/collection' }

      its(:collection) { should be_a_kind_of(Bgg::Result::Collection) }
    end
  end
end
