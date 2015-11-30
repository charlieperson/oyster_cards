require "oystercard"

describe Oystercard do
  subject(:card) { described_class.new }

  it "has a balance" do
    expect(card).to respond_to(:balance)
  end

end
