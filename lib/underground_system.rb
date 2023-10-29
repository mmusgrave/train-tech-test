class UndergroundSystem
  #start with int then make it float

  def initialize
    @customers_hash = {}
  end

  def check_in(id, station_name, time)
    # Create a new customer object in hash with their id as key if one does not exist already
    if !@customers_hash.has_key?(id)
      @customers_hash[id] = { checked_in?: false, trips: [] } # Creates key-value pair for customer
    end

    # If the customer is checked in, they can't check in again
    return "This customer has already been checked in" if @customers_hash[id][:checked_in?] # TODO: error handling

    @customers_hash[id][:checked_in?] = true
    @customers_hash[id][:trips] << {start_time: time, start_station: station_name}
  end

  def check_out(id, station_name, time)
    # The last one on the array should be the open trip # TODO: test this assumption
    current_trip = @customers_hash[id][:trips].last()

    if !finished_trip?(current_trip)
    #Make sure that the trip is an open trip
      current_trip[:end_time] = time
      current_trip[:end_station] = station_name
    else
      # raise
      return "This customer has no open trips"
    end
  end

  def get_average_time(start_station, end_station)
    valid_trip_lengths = []
    valid_trip_counter = 0
    @customers_hash.each do |customer_id, customer_info|
      customer_info[:trips].each do |trip|
        if finished_trip?(trip) && matching_trip?(trip, start_station, end_station)
          valid_trip_lengths << (trip[:end_time] - trip[:start_time]) # Length of trip
          valid_trip_counter += 1
        end
      end
    end
    # Sum up distances and divide by number of trips for average
    return (valid_trip_lengths.sum/valid_trip_counter)
  end

  private

  def matching_trip?(trip, other_start, other_end)
    return trip[:start_station] == other_start && trip[:end_station] == other_end
  end

  def finished_trip?(trip)
    return trip[:end_station] != nil
  end
end
