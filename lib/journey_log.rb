class Journey_log
  attr_reader :log
  attr_accessor :current_journey

  def initialize
    @log = {}
    @current_journey = []
  end
end
