class Oystercard
  MAX_LIMIT = 90
  FARE = 1

  attr_reader :balance, :current_trip, :trips

  def initialize
    @balance = 0
    @current_trip = []
    @trips = {}
  end

  def top_up(amount)
    raise "Sorry mate- Limit is #{MAX_LIMIT}" if maxed_out(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Sorry mate- you need a top up!" if out_of_cash?
    current_trip << entry_station
  end

  def touch_out(exit_station)
    current_trip << exit_station
    save_trip
    reset_trip
    charge_card
  end

  def in_journey?
    !current_trip.empty?
  end

  private

  def charge_card
    @balance -= FARE
  end

  def reset_trip
    @current_trip = []
  end

  def maxed_out(amount)
    @balance + amount > MAX_LIMIT
  end

  def save_trip
    @trips[@trips.length + 1] = @current_trip
  end

  def out_of_cash?
    FARE > @balance
  end

end
