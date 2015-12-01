require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:entry_station)  { double(:entry_station)    }

  describe '#balance' do
    it 'has a balance of 0' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'can be topped up' do
      card.top_up(described_class::MAX_LIMIT)
      expect(card.balance).to eq described_class::MAX_LIMIT
    end

    context 'exceeds max limit' do
      it 'raises error when max limit is exceeded' do
        card.top_up(described_class::MAX_LIMIT)
        expect{ card.top_up(1) }.to raise_error "Sorry mate- Limit is #{described_class::MAX_LIMIT}"
      end
    end
  end

  describe '#deduct' do
    it 'deducts fare from balance' do
      card.top_up(described_class::MAX_LIMIT)
      expect{ card.deduct(described_class::FARE) }.to change{ card.balance }.by -described_class::FARE
    end
  end

    describe '#touch_in' do
      it 'changes journey_in attribute to true' do
        card.top_up(described_class::MAX_LIMIT)
        expect{ card.touch_in(entry_station) }.to change{ card.in_journey? }.to eq true
      end
      it 'should record entry_station on touch_in' do
        card.top_up(described_class::MAX_LIMIT)
        card.touch_in(entry_station)
        expect(card.entry_station).to eq entry_station
      end
      context 'balance of card is less than fare' do
        it 'raises error if card balance is below fare' do
          expect{ card.touch_in(entry_station) }.to raise_error"Sorry mate- you need a top up!"
        end
      end
    end

    describe '#touch_out' do
      it 'checks if card.in_journey? returns false upon touch_out' do
        card.top_up(described_class::MAX_LIMIT)
        card.touch_in(entry_station)
        expect{ card.touch_out }.to change{ card.in_journey? }.to eq false
      end
      it 'subtracts FARE from balance' do
        expect{ card.touch_out }.to change{ card.balance }.by -described_class::FARE
      end
      it 'entry_station attribute reverts to nil upon touch_out' do
        card.top_up(described_class::MAX_LIMIT)
        card.touch_in(entry_station)
        expect{ card.touch_out }.to change{ card.entry_station }.to eq nil
      end

    end
end
