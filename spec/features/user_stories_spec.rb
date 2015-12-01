require 'station.rb'

describe "User Stories" do
  let(:card)    { Oystercard.new }
  let(:station) { Station.new    }

  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'card is initialized with a balance of 0' do
    expect(card.balance).to eq 0
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card
  it 'can top up the balance' do
    card.top_up(Oystercard::MAX_LIMIT)
    expect(card.balance).to eq Oystercard::MAX_LIMIT
  end

  # In order to protect my money from theft or loss
  # As a customer
  # I want a maximum limit (of £90) on my card
  it 'applies maximum limit of £90 on cards' do
     card.top_up(Oystercard::MAX_LIMIT)
     expect { card.top_up(1) }.to raise_error "Sorry mate- Limit is #{Oystercard::MAX_LIMIT}"
  end

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it 'fare is deducted from card balance' do
    card.top_up(Oystercard::MAX_LIMIT)
    expect{ card.deduct(3) }.to change{ card.balance }.by -3
  end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.
  it 'allows users to touch in' do
    card.top_up(Oystercard::MAX_LIMIT)
    card.touch_in(station)
    expect(card.in_journey).to eq true
  end

  it 'allows users to touch out' do
    card.top_up(Oystercard::MAX_LIMIT)
    card.touch_in(station)
    expect{ card.touch_out }.to change { card.in_journey }.to eq false
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.
  it 'ensures customers have £1 at touch_in' do
    expect{ card.touch_in(station) }.to raise_error 'Sorry mate- you need a top up!'
  end

  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card
  it 'charges customers appropriate fare when they touch out' do
    expect{ card.touch_out }.to change{ card.balance }.by -Oystercard::FARE
  end

  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from
  it 'card needs to record touch_in station' do
    card.top_up(Oystercard::MAX_LIMIT)
    card.touch_in(station)
    expect(card.station).to eq station
  end
end
