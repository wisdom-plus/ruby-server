require 'date'

module Util
  class << self
    def get_utc_date_string
      utc_date_string = DateTime.now.new_offset.strftime('%a, %d, %b, %Y, %H:%M:%S %Z GMT')
    end
  end
end
