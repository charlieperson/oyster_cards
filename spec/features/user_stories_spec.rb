describe "User Stories" do

  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'card has a balance' do
    card = Oystercard.new
    expect(card).to respond_to(:balance)
  end

  it 'card is initialized with a balance of 0' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end
end
