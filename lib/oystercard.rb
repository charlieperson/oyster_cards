class Oystercard
  MAX_LIMIT = 90
  FARE = 1

  attr_reader :balance, :entry_station, :exit_station, :trip

  def initialize
    @balance = 0
    @entry_station = nil
    @trip = []
  end

  def top_up(amount)
    raise "Sorry mate- Limit is #{MAX_LIMIT}" if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in(entry_station)
    raise "Sorry mate- you need a top up!" if out_of_cash?
    @entry_station = entry_station
    trip << entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    @entry_station = nil
    trip << exit_station
    @balance -= FARE
  end

  def in_journey?
    !!@entry_station
  end

  private

  def out_of_cash?
    FARE > @balance
  end

end
