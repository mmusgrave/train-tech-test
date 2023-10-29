# require 'ostruct'

class UndergroundSystem
  #start with int then make it float

  def initialize
    @master_users_hash = {}
  end

  def check_in(id, station_name, time)
    # Create a new user object in hash with their id as key if one does not exist already
    if !@master_users_hash.has_key?(id)
      @master_users_hash[id] = { checked_in?: false, trips: [] } # Creates key-value pair for user
    end

    # If the user is checked in, they can't check in again
    return "This user has already been checked in" if @master_users_hash[id][:checked_in?] # TODO: error handling

    @master_users_hash[id][:checked_in?] = true
    @master_users_hash[id][:trips] << {start_time: time, start_station: station_name}
  end

  def check_out(id, station_name, time)
    # The last one on the array should be the open trip # TODO: test this assumption
    current_trip = @master_users_hash[id][:trips].last()
    current_trip[:end_time] = time
    current_trip[:end_station] = station_name
  end

  def get_average_time(start_station, end_station)
    valid_trip_lengths = []
    valid_trip_counter = 0
    @master_users_hash.each do |user_id, user_info|
      user_info[:trips].each do |trip|
        if trip[:end_station] != nil && trip[:start_station] == start_station && trip[:end_station] == end_station
        # Check for finished trip and then matching trips
        # nil check aboves also prevents a user passing nil as an argument
          valid_trip_lengths << (trip[:end_time] - trip[:start_time]) # Length of trip
          valid_trip_counter += 1
        end
      end
    end
    # Sum up distances and divide by number of trips for average
    return (valid_trip_lengths.sum/valid_trip_counter)
  end
end
