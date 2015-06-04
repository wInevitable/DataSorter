class DataSorter
  # Initializes the DataSorter data attribute from specific files
  def initialize(*files)
    @data = ''
    # Add/Remove delimiters as necessary, Space is Default
    @delimiters = [',', '|']

    files.each do |f|
    end
  end

  # Sorts by Gender (females before males) and then Last Name (ascending)
  def gender_sort
    return @data
  end

  # Sorts by Date of Birth (ascending)
  def dob_sort
    return @data
  end

  # Sorts by Last Name (descending)
  def last_name_sort
    return @data
  end

  private
  # Parses individual files based off of chosen delimiters
  def parser(file)

  end
end