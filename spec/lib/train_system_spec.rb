require './lib/underground_system'

RSpec.describe UndergroundTrip do
end

RSpec.describe UndergroundSystem do
  it 'works' do
    tube = UndergroundSystem.new
    tube.check_in(45, 'Leyton', 3)
    tube.check_in(32, 'Paradise', 8)
    tube.check_out(45, 'Waterloo', 15)
    tube.check_out(32, 'Cambridge', 22)
    ans = tube.get_average_time('Paradise', 'Cambridge')
    expect(ans).to eq 14
  end

  it 'works on a more complicated example' do
    # ## Example 1
    #
    # Input
    # ```
    # check_in,45,Leyton,3
    # check_in,32,Paradise,8
    # check_in,27,Leyton,10
    # check_out,45,Waterloo,15
    # check_out,27,Waterloo,20
    # check_out,32,Cambridge,22
    # get_average,Paradise,Cambridge
    # get_average,Leyton,Waterloo
    # check_in,10,Leyton,24
    # get_average,Leyton,Waterloo
    # check_in,10,Waterloo,38     ******* Should this be check_out,10,Waterloo,38?
    # get_average,Leyton,Waterloo
    # ```
    #
    # Output
    # ```
    # Paradise,Cambridge,14.0
    # Leyton,Waterloo,11.0
    # Leyton,Waterloo,12.0
    # ```
    tube = UndergroundSystem.new
    tube.check_in(45, 'Leyton', 3)
    tube.check_in(32, 'Paradise', 8)
    tube.check_in(27, 'Leyton', 10)

    tube.check_out(45, 'Waterloo', 15)
    tube.check_out(27, 'Waterloo', 20)
    tube.check_out(32, 'Cambridge', 22)

    ans = tube.get_average_time('Paradise', 'Cambridge')
    expect(ans).to eq 14

    ans = tube.get_average_time('Leyton', 'Waterloo')
    expect(ans).to eq 11

    tube.check_in(10, 'Leyton', 24)

    # ans = tube.get_average_time('Leyton', 'Waterloo')
    # expect(ans).to eq nil # ???? or 11?

    # tube.check_in(10, 'Waterloo', 38) ??????
    tube.check_out(10, 'Waterloo', 38)

    ans = tube.get_average_time('Leyton', 'Waterloo')
    expect(ans).to eq 12
  end
end
