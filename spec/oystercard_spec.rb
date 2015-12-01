require "oystercard"

describe Oystercard do
  subject(:card) { described_class.new }


  describe "#balance" do
    it 'has a balance of 0' do
      expect(card.balance).to eq 0
    end
  end

  describe "#top_up" do
    it 'can be topped up' do
      card.top_up(10)
      expect(card.balance).to eq 10
    end

    context "exceeds max limit" do
      it 'raises error when max limit is exceeded' do
        card.top_up(described_class::MAX_LIMIT)
        expect{ card.top_up(1) }.to raise_error "Sorry mate- Limit is #{Oystercard::MAX_LIMIT}"
      end
    end
  end

  describe "#deduct" do
    it 'deducts fare from balance' do
      card.top_up(90)
      expect{ card.deduct(3) }.to change{ card.balance }.by -3
    end
  end
end
