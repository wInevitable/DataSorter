class DataSorter
  # Initializes the DataSorter data attribute from specific files
  def initialize(*files)
    # Add/Remove delimiters as necessary, Space is Default
    @delimiters = [',', '|']
    @data = []

    files.each do |f|
      @data += parser(f) # returns arr of arrays => [[df_1], [df_2], ...]
    end

    print @data
  end

  # Sorts by Gender (females before males) and then Last Name (ascending)
  def gender_sort
    # sort data
    return @data
  end

  # Sorts by Date of Birth (ascending)
  def dob_sort
    # sort data
    return @data
  end

  # Sorts by Last Name (descending)
  def last_name_sort
    # sort data
    return @data
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
        if el.upcase == 'M' # Handle Gender
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