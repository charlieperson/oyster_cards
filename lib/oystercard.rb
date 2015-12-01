class Oystercard
  MAX_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Sorry mate- Limit is #{MAX_LIMIT}" if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

end
