class Oystercard
  MAX_LIMIT = 90

  attr_reader :balance, :in_journey

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

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
