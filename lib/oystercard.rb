class Oystercard
  MAX_LIMIT = 90
  FARE = 1

  attr_reader :balance, :in_journey, :station

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Sorry mate- Limit is #{MAX_LIMIT}" if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in(station)
    raise "Sorry mate- you need a top up!" if out_of_cash?
    @station = station
    @in_journey = true
  end

  def touch_out
    @balance -= FARE
    @in_journey = false
  end

  private

  def out_of_cash?
    FARE > @balance
  end

end
