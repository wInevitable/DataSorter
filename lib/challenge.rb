class DataSorter
  # Initializes the DataSorter data attribute from specific files
  def initialize(*files)
    # Add/Remove delimiters as necessary, Space is Default
    @delimiters = [',', '|']
    @data = []

    files.each do |f|
      @data += parser(f) # returns arr of arrays => [[df_1], [df_2], ...]
    end
  end

  # Data ~= [LName, FName, Gender, DOB, Color]
  # Sorts by Gender (females before males) and then Last Name (ascending)
  def gender_sort # [Index 2, then Index 0]
    sorted_array = @data.sort do |a, b|
      comp = (a[2] <=> b[2])
      comp.zero? ? (a[0] <=> b[0]) : comp
    end

    sorted_array.map! { |arr| arr.join(' ') }
    return sorted_array.join("\n")
  end

  # Sorts by Date of Birth (ascending) [Index 3]
  def dob_sort
    sorted_array = @data.sort do |a, b|
      date_a = a[3].split('/')
      date_b = b[3].split('/')

      comp = (date_a[2] <=> date_b[2])
      comp = comp.zero? ? (date_a[0] <=> date_b[0]) : comp
      comp.zero? ? (date_a[1] <=> date_b[1]) : comp
    end

    sorted_array.map! { |arr| arr.join(' ') }
    return sorted_array.join("\n")
  end

  # Sorts by Last Name (descending) [Index 0]
  def last_name_sort
    sorted_array = @data.sort_by { |arr| arr[0] }
    sorted_array = sorted_array.reverse.map! { |arr| arr.join(' ') }
    return sorted_array.join("\n")
  end

  private
  # Parses individual files based off of chosen delimiters
  # Returns an Array of Lines
  def parser(file)
    delimiter = ' '
    parsed_file = []
    input_rows = IO.readlines('data/' + file)

    # Pick File-Specific Delimiter
    @delimiters.each do |d|
      if input_rows[0].include?(d)
        delimiter = d
        break
      end
    end

    input_rows.each_with_index do |row, i|
      fields = row.split(delimiter) # arr of fields
      parsed_file << clean_data(fields)
    end

    parsed_file
  end

  def clean_data(arr)
    # Desired Order = [LName, FName, Gender, DOB, Color]
    formatted_array = []

    arr.delete_at(2) if arr.length > 5 # drop initials

    arr.each_with_index do |el, i|
      el.gsub!(' ', '')
      el.gsub!("\n", '')

      if i < 2
        formatted_array << el # Handle Last and First Names
      elsif i == 2
        if el[0].upcase == 'M' # Handle Gender
          formatted_array << 'Male'
        else
          formatted_array << 'Female'
        end
      else
        if el.include?('/')
          formatted_array[3] = el
        elsif el.include?('-')
          formatted_array[3] = el.gsub('-', '/')
        else # Handle Colors
          formatted_array[4] = el
        end
      end
    end

    formatted_array
  end
end