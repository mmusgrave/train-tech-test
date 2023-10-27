# require 'ostruct'

class UndergroundSystem
  #start with int then make it float

  def initialize
    @checked_in_users = {} # A hash, where each key is the user id, and the value is whether or not they are already checked in for a trip
    @trips = [] # An array (or maybe a hash?), where you store each trip

    @check_ins_by_station_name = {}

    # New idea: a Hash with the user ID that stores all their trips
    @master_users_hash = {}

    # a hash with the idea as the station name that stores all check ins
    # a hash with the idea as the station name that stores all check outs

    #use Hash.each for iteration
  end

  def check_in(id, station_name, time)
    # Add new user trip

    if !@master_users_hash.has_key?(id)
      @master_users_hash[id] = { checked_in?: false, trips: [] } # Creates key-value pair for user
    end

    return "This user has already been checked in" if @master_users_hash[id][:checked_in?] # TODO: error handling

    @master_users_hash[id][:checked_in?] = true
    @master_users_hash[id][:trips] << {start_time: time, start_station: station_name}
    # @master_users_hash[id][:trips] << UndergroundTrip.new(start_time: time, start_station: station_name)
    # { checked_in?: true, trips: [UndergroundTrip.new(start_time: time, start_station: station)] }



    # @trips << UndergroundTrip.new(id, time, station_name)
    # @check_ins_by_station_names[station_name] =
  end

  def check_out(id, station_name, time)
    current_trip = @master_users_hash[id][:trips].last() # As the one on the array should be the open trip
    current_trip.end_time = time
    current_trip.end_station = station_name
  end

  def get_average_time(start_station, end_station)
    valid_trip_distances = []
    valid_trip_counter = 0
    @master_users_hash.each do |user_id, user_info|
      user_info[:trips].each do |trip|
        if trip.finished? && trip.qualifies?(start_station, end_station)
          valid_trip_distances << trip.length
          valid_trip_counter += 1
        end
      end
    end
    return (valid_trip_distances.sum/valid_trip_counter) # Sum up distances and divide by number of trips for average
    # return (array.sum.to_f/valid_trip_counter.to_f)
  end
end

class UndergroundTrip

  attr_reader :start_time, :start_station, :end_time, :end_station
  attr_writer :end_time, :end_station

  def initialize(start_time:, start_station:)
    @start_time = start_time
    @start_station = start_station
    @end_time = nil
    @end_station = nil
  end

  # A trip only qualifies if it's finished
  # We only check for the trip length if it qualifies

  def finished?
    # If the end_station is nil, then the trip is not finished,
    # but if an end_station has been set, the trip is finished
    # using Ternary operator
    return (@end_station == nil ? false : true)
  end

  def length
    # First implementation
    # return "This trip has not yet finished" if !self.finished?
    # return (@end_time - @start_time)

    # If the trip is finished, we can calculate the length
    # if the trip is not finished, we cannot
    # using Ternary operator
    return (self.finished? ? (@end_time - @start_time) : "This trip has not yet finished")
  end

  def qualifies?(other_start, other_end)
    # If the trip start and end stations match the start and end arguments, the trips qualifies
    # If there is any mismatch, the trip does not qualify
    return false if !self.finished
    return ((@start_station == other_start && @end_station == other_end) ? true : false )
  end
end
