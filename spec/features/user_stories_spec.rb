require 'station.rb'
require 'oystercard'

describe "User Stories" do
  let(:card)    { Oystercard.new }
  let(:station) { Station.new('Wapping', 2)    }

  fare         = -Oystercard::FARE
  max_limit    = Oystercard::MAX_LIMIT
  # penalty_fine = -Oystercard::FINE


  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'card is initialized with a balance of 0' do
    expect(card.balance).to eq 0
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.
  it 'ensures customers have £1 at touch_in' do
    expect{ card.touch_in(station) }.to raise_error 'Sorry mate- you need a top up!'
  end

  describe 'initialize with balance of max_limit' do
    before do
      card.top_up(max_limit)
    end
    # In order to keep using public transport
    # As a customer
    # I want to add money to my card
    it 'can top up the balance' do
      expect(card.balance).to eq max_limit
    end

    # In order to protect my money from theft or loss
    # As a customer
    # I want a maximum limit (of £90) on my card
    it 'applies maximum limit of £90 on cards' do
       expect { card.top_up(1) }.to raise_error "Sorry mate- Limit is #{max_limit}"
    end

    # In order to pay for my journey
    # As a customer
    # I need my fare deducted from my card
    it 'fare is deducted from card balance' do
      expect{ card.touch_out(station) }.to change{ card.balance }.by fare
    end

    # In order to get through the barriers.
    # As a customer
    # I need to touch in and out.
    it 'allows users to touch in' do
      card.touch_in(station)
      expect(card.in_journey?).to eq true
    end

    it 'allows users to touch out' do
      card.touch_in(station)
      expect{ card.touch_out(station) }.to change { card.in_journey? }.to eq false
    end
    # In order to pay for my journey
    # As a customer
    # When my journey is complete, I need the correct amount deducted from my card
    it 'charges customers appropriate fare when they touch out' do
      expect{ card.touch_out(station) }.to change{ card.balance }.by fare
    end
    # In order to pay for my journey
    # As a customer
    # I need to know where I've travelled from
    it 'card needs to log entry station to current_trip upon touch_in' do
      card.touch_in(station)
      expect(card.current_trip).to eq [station]
    end

    it 'card needs to reset current_trip on touch_out' do
      card.touch_in(station)
      expect{ card.touch_out(station) }.to change{ card.in_journey? }.to eq false
    end

    # In order to know where I have been
    # As a customer
    # I want to see to all my previous trips
    it 'card stores current trip' do
      card.touch_in(station)
      card.touch_out(station)
      expect(card.trips[card.trips.length]).to eq [station, station]
    end
  end

  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in
  it 'expects station to have a name' do
    expect(station.name).to eq 'Wapping'
  end
  it 'expects station to have a zone' do
    expect(station.zone).to eq 2
  end

  # # In order to be charged correctly
  # # As a customer
  # # I need a penalty charge deducted if I fail to touch in or out
  # it 'card deducts penalty charge if user does not touch out' do
  #   card.touch_in(station)
  #   expect{ card.touch_in(station) }.to change{ card.balance }.by penalty_fine
  # end
end
