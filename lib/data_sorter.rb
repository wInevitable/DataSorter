class DataSorter
  # Initializes the DataSorter data attribute from specific files
  def initialize(*files)
    # Add/Remove delimiters as necessary, Space is Default
    @default_delimiter = ' '
    @delimiters = [',', '|']
    @data = []

    # Read through each File with the Parser
    # Returns an Array of Hashes [{Last name: 'x', ...}, {}, {}]
    files.each do |f|
      @data += parser(f)
    end
  end

  # Place Any Desired Sorters Below
  # Each is Responsible for Sorting the Parsed Data
  # And Passing it to the Render Function

  # Sorts by Date of Birth (ascending)
  def dob_sort
    sorted_array = @data.sort do |a, b|
      date_a = a[:date].split('/')
      date_b = b[:date].split('/')

      # Sort by Year first, then Month, then Day
      comp = (date_a[2] <=> date_b[2])
      comp = comp.zero? ? (date_a[0] <=> date_b[0]) : comp
      comp.zero? ? (date_a[1] <=> date_b[1]) : comp
    end

    render(sorted_array)
  end

  # Sorts by Gender (females before males) and then Last Name (ascending)
  def gender_sort
    sorted_array = @data.sort do |a, b|
      comp = (a[:gender] <=> b[:gender])
      comp.zero? ? (a[:last_name] <=> b[:last_name]) : comp
    end

    render(sorted_array)
  end

  # Sorts by Last Name (descending)
  def last_name_sort
    sorted_array = @data.sort_by { |hash| hash[:last_name] }
    render(sorted_array.reverse)
  end

  private
  # Assists in Parsing Data, Takes in an Array of Fields broken by Delimiters
  # Should Return a Hash with Proper Key/Value Pairs
  # TODO Feels a little hacky...a better way?
  def clean_data(arr)
    formatted_data = {}

    arr.delete_at(2) if arr.length > 5 # Drop Initials

    arr.each_with_index do |el, i|
      # Remove any remaining Whitespace/New Line Characters
      el.gsub!(/\s+/, '')

      case i
      when 0
        formatted_data[:last_name] = el
      when 1
        formatted_data[:first_name] = el
      when 2
        formatted_data[:gender] = el[0].upcase == 'M' ? 'Male' : 'Female'
      else
        if el.include?('/')
          formatted_data[:date] = el
        elsif el.include?('-')
          formatted_data[:date] = el.gsub('-', '/')
        else
          formatted_data[:fav_color] = el
        end
      end
    end

    formatted_data
  end

  # Handles Program Input, splitting Files into Lines into Delimited Arrays
  # Returns an Array of Hashes/Data Objects [{Last name: 'x', ...}, {}, {}]
  def parser(file)
    delimiter = @default_delimiter
    parsed_file = []
    input_rows = IO.readlines('data/' + file)

    # Choose File-Specific Delimiter
    @delimiters.each do |d|
      if input_rows[0].include?(d)
        delimiter = d
        break
      end
    end

    input_rows.each do |line|
      fields = line.split(delimiter)
      parsed_file << clean_data(fields)
    end

    parsed_file
  end

  # Handles Program Output
  # Takes Sorted Data and Returns (or optionally prints) in Desired Order
  # TODO Feels a little hacky...a better way?
  def render(sorted_array)
    # Orders each specific Object in attribute order
    # Desired Order = [LName, FName, Gender, DOB, Color]
    sorted_array.map! do |hash|
      hash = hash[:last_name] + " " + hash[:first_name] + " " + hash[:gender] + " " + hash[:date] + " " + hash[:fav_color]
    end

    # Joins all Objects with new lines
    return sorted_array.join("\n")
  end
end