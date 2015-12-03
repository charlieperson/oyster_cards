require_relative 'journey_log'

class Oystercard
  MAX_LIMIT = 90
  FARE = 1
  PENALTY_FINE = 20

  attr_reader :balance, :journey_log

  def initialize
    @balance = 0
    @journey_log = Journey_log.new
  end

  def top_up(amount)
    raise "Sorry mate- Limit is #{MAX_LIMIT}" if maxed_out(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Sorry mate- you need a top up!" if out_of_cash?
    @journey_log.current_journey << entry_station
    penalize_on_touch_in?
  end

  def touch_out(exit_station)
    penalize_on_touch_out?
    @journey_log.current_journey << exit_station
    save_trip
    reset_trip
    charge_card
  end

  def in_journey?
    !@journey_log.current_journey.empty?
  end


  private

  def penalize_on_touch_out?
    @balance -= PENALTY_FINE if @journey_log.current_journey.empty?
  end

  def penalize_on_touch_in?
    @balance -= PENALTY_FINE if @journey_log.current_journey.length > 0
  end

  def charge_card
    @balance -= FARE
  end

  def reset_trip
    @journey_log.current_journey = []
  end

  def maxed_out(amount)
    @balance + amount > MAX_LIMIT
  end

  def save_trip
    @journey_log.log[@journey_log.log.length + 1] = @journey_log.current_journey
  end

  def out_of_cash?
    FARE > @balance
  end

end
