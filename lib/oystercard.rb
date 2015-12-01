class Oystercard
  MAX_LIMIT = 90
  FARE = 1

  attr_reader :balance, :entry_station, :trip, :trips

  def initialize
    @balance = 0
    @entry_station = nil
    @trip = []
    @trips = {}
  end

  def top_up(amount)
    raise "Sorry mate- Limit is #{MAX_LIMIT}" if maxed_out(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Sorry mate- you need a top up!" if out_of_cash?
    @entry_station = entry_station
    trip << entry_station
  end

  def touch_out(exit_station)
    @entry_station = nil
    trip << exit_station
    save_trip
    reset_trip
    charge_card
  end

  def in_journey?
    !!@entry_station
  end

  private

  def charge_card
    @balance -= FARE
  end

  def reset_trip
    @trip = []
  end

  def maxed_out(amount)
    @balance + amount > MAX_LIMIT
  end

  def save_trip
    @trips[@trips.length + 1] = @trip
  end

  def out_of_cash?
    FARE > @balance
  end

end
