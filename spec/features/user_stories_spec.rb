describe "User Stories" do
  let(:card) { Oystercard.new }

  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'card has a balance' do
    expect(card).to respond_to(:balance)
  end

  it 'card is initialized with a balance of 0' do
    expect(card.balance).to eq 0
  end

  #In order to keep using public transport
  #As a customer
  #I want to add money to my card
  it 'can add money to card' do
    card.top_up! 10
    expect(card.balance).to eq 10
  end
end
