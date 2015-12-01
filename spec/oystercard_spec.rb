require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:station)  { double(:station)    }

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
        expect{ card.touch_in(station) }.to change{ card.in_journey }.to eq true
      end
      it 'should record touch_in station' do
        card.top_up(described_class::MAX_LIMIT)
        card.touch_in(station)
        expect(card.station).to eq station
      end
      context 'balance of card is less than fare' do
        it 'raises error if card balance is below fare' do
          expect{ card.touch_in(station) }.to raise_error"Sorry mate- you need a top up!"
        end
      end
    end

    describe '#touch_out' do
      it 'changes in_journey attribute to false' do
        card.top_up(described_class::MAX_LIMIT)
        card.touch_in(station)
        expect{ card.touch_out }.to change{ card.in_journey }.to eq false
      end

      it 'subtracts FARE from balance' do
        expect{ card.touch_out }.to change{ card.balance }.by -described_class::FARE
      end
    end
end
