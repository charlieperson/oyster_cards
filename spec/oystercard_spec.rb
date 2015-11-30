require "oystercard"

describe Oystercard do
  subject(:card) { described_class.new }

  it "has a balance" do
    expect(card).to respond_to(:balance)
  end

  it 'is initialized with balance of 0' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

end
