require "journey"

describe Journey do
  let(:card)    { double :card   }
  let(:station) { double :station }

  it 'card instantiates new journey' do
    expect(subject.log).to eq []
  end
end
