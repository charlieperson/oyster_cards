describe "User Stories" do

  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'card has money' do
    card = Oystercard.new
    expect(card).to respond_to(:balance)
  end

end
