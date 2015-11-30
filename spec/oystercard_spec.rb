require "oystercard"

describe Oystercard do
  subject(:card) { described_class.new }

  describe '#balance' do
    it "has a balance" do
      expect(card).to respond_to(:balance)
    end

    it 'is initialized with balance of 0' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up!' do
    it 'can be topped up' do
      card.top_up! 10
      expect(card.balance).to eq 10
    end
  end
end
