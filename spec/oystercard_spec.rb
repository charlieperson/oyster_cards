require 'oystercard'

describe Oystercard do
  subject(:card)      { described_class.new    }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station)  { double(:exit_station)  }

  fare      = -described_class::FARE
  max_limit = described_class::MAX_LIMIT

  describe '#balance' do
    it 'has a balance of 0' do
      expect(card.balance).to eq 0
    end
    it 'raises error if card balance is below fare' do
      expect{ card.touch_in(entry_station) }.to raise_error"Sorry mate- you need a top up!"
    end
  end

  context 'tests that require a topped up card' do

    before do
      card.top_up(max_limit)
    end

    describe '#top_up' do
      it 'can be topped up' do
        expect(card.balance).to eq max_limit
      end
      it 'raises error when max limit is exceeded' do
        expect{ card.top_up(1) }.to raise_error "Sorry mate- Limit is #{max_limit}"
      end
    end

    describe '#touch_out' do
      it 'checks if card.in_journey? returns false upon touch_out' do
        card.touch_in(entry_station)
        expect{ card.touch_out(exit_station) }.to change{ card.in_journey? }.to eq false
      end
      it 'subtracts FARE from balance' do
        expect{ card.touch_out(exit_station) }.to change{ card.balance }.by fare
      end
      it 'entry_station attribute reverts to nil upon touch_out' do
        card.touch_in(entry_station)
        expect{ card.touch_out(exit_station) }.to change{ card.entry_station }.to eq nil
      end
    end

    describe '#touch_in' do
      it 'changes journey_in attribute to true' do
        expect{ card.touch_in(entry_station) }.to change{ card.in_journey? }.to eq true
      end
      it 'should record entry_station on touch_in' do
        card.touch_in(entry_station)
        expect(card.entry_station).to eq entry_station
      end
    end

    describe '#trip' do
      before do
        card.touch_in(entry_station)
        card.touch_out(exit_station)
      end
      it 'trip is cleared upon touch_out' do
        expect(card.trip).to eq []
      end
      it 'logs one trip after touch_in and touch_out' do
        expect(card.trips.length).to eq 1
      end
    end

  end

end
