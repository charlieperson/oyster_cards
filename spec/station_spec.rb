require 'station'

describe Station do

  subject(:station) { described_class.new('Wapping', 2) }

  it 'initializes with a name' do
    expect(station.name).to eq 'Wapping'
  end
  it 'initializes with zone' do
    expect(station.zone).to eq 2
  end

end
