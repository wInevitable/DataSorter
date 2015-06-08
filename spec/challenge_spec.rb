require 'rspec'
require 'challenge'

describe DataSorter do
  subject(:sorter) { DataSorter.new('comma_delimited.txt', 'pipe_delimited.txt', 'space_delimited.txt') }

  it "sorts by Gender (females before males) and then Last Name ascending" do
    gender_sorted_string = 'Hingis Martina Female 4/2/1979 Green
Kelly Sue Female 7/12/1959 Pink
Kournikova Anna Female 6/3/1975 Red
Seles Monica Female 12/2/1973 Black
Abercrombie Neil Male 2/13/1943 Tan
Bishop Timothy Male 4/23/1967 Yellow
Bonk Radek Male 6/3/1975 Green
Bouillon Francis Male 6/3/1975 Blue
Smith Steve Male 3/3/1985 Red'

    expect(sorter.gender_sort).to eq(gender_sorted_string)
  end

  it "sorts by Birth Date ascending" do
    date_of_birth_sorted_string = 'Abercrombie Neil Male 2/13/1943 Tan
Kelly Sue Female 7/12/1959 Pink
Bishop Timothy Male 4/23/1967 Yellow
Seles Monica Female 12/2/1973 Black
Bonk Radek Male 6/3/1975 Green
Bouillon Francis Male 6/3/1975 Blue
Kournikova Anna Female 6/3/1975 Red
Hingis Martina Female 4/2/1979 Green
Smith Steve Male 3/3/1985 Red'

    expect(sorter.dob_sort).to eq(date_of_birth_sorted_string)
  end

  it "sorts by Last Name descending" do
    last_name_sorted_string = 'Smith Steve Male 3/3/1985 Red
Seles Monica Female 12/2/1973 Black
Kournikova Anna Female 6/3/1975 Red
Kelly Sue Female 7/12/1959 Pink
Hingis Martina Female 4/2/1979 Green
Bouillon Francis Male 6/3/1975 Blue
Bonk Radek Male 6/3/1975 Green
Bishop Timothy Male 4/23/1967 Yellow
Abercrombie Neil Male 2/13/1943 Tan'

    expect(sorter.last_name_sort).to eq(last_name_sorted_string)
  end
end