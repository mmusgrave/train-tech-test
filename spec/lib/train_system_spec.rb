require './lib/underground_system'

RSpec.describe UndergroundSystem do
  it 'properly gets average distance' do
    tube = UndergroundSystem.new

    tube.check_in(id: 10, station_name: 'Leyton', time: 1)
    tube.check_out(id: 10, station_name: 'Waterloo', time: 2)

    ans = tube.get_average_time(start_station: 'Leyton', end_station: 'Waterloo')
    expect(ans).to eq 1
  end

  it 'properly gets demical average distance' do
    tube = UndergroundSystem.new

    tube.check_in(id: 10, station_name: 'Leyton', time: 1)
    tube.check_out(id: 10, station_name: 'Waterloo', time: 2)
    tube.check_in(id: 30, station_name: 'Leyton', time: 3)
    tube.check_out(id: 30, station_name: 'Waterloo', time: 7)

    ans = tube.get_average_time(start_station: 'Leyton', end_station: 'Waterloo')
    expect(ans).to eq 2.5
  end

  it 'works on a simple example' do
    tube = UndergroundSystem.new
    tube.check_in(id: 45, station_name: 'Leyton', time: 3)
    tube.check_in(id: 32, station_name: 'Paradise', time: 8)
    tube.check_out(id: 45, station_name: 'Waterloo', time: 15)
    tube.check_out(id: 32, station_name: 'Cambridge', time: 22)
    ans = tube.get_average_time(start_station: 'Paradise', end_station: 'Cambridge')
    expect(ans).to eq 14
  end

  it 'works on a more complicated example with a change of average' do
    tube = UndergroundSystem.new

    tube.check_in(id: 45, station_name: 'Leyton', time: 3)
    tube.check_in(id: 32, station_name: 'Paradise', time: 8)
    tube.check_in(id: 27, station_name: 'Leyton', time: 10)

    tube.check_out(id: 45, station_name: 'Waterloo', time: 15)
    tube.check_out(id: 27, station_name: 'Waterloo', time: 20)
    tube.check_out(id: 32, station_name: 'Cambridge', time: 22)

    ans = tube.get_average_time(start_station: 'Paradise', end_station: 'Cambridge')
    expect(ans).to eq 14

    ans = tube.get_average_time(start_station: 'Leyton', end_station: 'Waterloo')
    expect(ans).to eq 11

    tube.check_in(id: 10, station_name: 'Leyton', time: 24)
    tube.check_out(id: 10, station_name: 'Waterloo', time: 38)

    ans = tube.get_average_time(start_station: 'Leyton', end_station: 'Waterloo')
    expect(ans).to eq 12
  end

  it 'raises a CheckInError on double check in' do
    tube = UndergroundSystem.new

    tube.check_in(id: 10, station_name: 'Leyton', time: 1)
    expect { tube.check_in(id: 10, station_name: 'Cambridge', time: 2) }.to raise_error(CheckInError)
  end

  it 'raises CheckOutError when there is no trip to check out' do
    tube = UndergroundSystem.new

    tube.check_in(id: 10, station_name: 'Leyton', time: 1)
    tube.check_out(id: 10, station_name: 'Waterloo', time: 2)
    expect { tube.check_out(id: 10, station_name: 'Waterloo', time: 3) }.to raise_error(CheckOutError)
  end

  it 'raies NoValidTripsError if there are no valid trips' do
    tube = UndergroundSystem.new

    expect { tube.get_average_time(start_station: 'Leyton', end_station: 'Waterloo') }.to raise_error(NoValidTripsError)
  end
end
