require './lib/underground_system'

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
    tube.check_out(10, 'Waterloo', 38)

    ans = tube.get_average_time('Leyton', 'Waterloo')
    expect(ans).to eq 12
  end
end
