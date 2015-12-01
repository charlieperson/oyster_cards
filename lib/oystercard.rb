class Oystercard
  MAX_LIMIT = 90
  FARE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
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
  end

  def touch_out
    @balance -= FARE
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def out_of_cash?
    FARE > @balance
  end

end
