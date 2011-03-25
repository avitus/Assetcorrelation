class Histogram
  
  def initialize(start, bin_size, num_bins)
    @start      = start                         # top of first bin
    @bin_size   = bin_size                      # size of bin
    @num_bins   = num_bins                      # number of bins, excluding top and bottom
    @end        = start + bin_size * num_bins   # bottom of last bin
    @histo      = Array.new(num_bins+2, 0)      # initialize histogram
    @median     = 0                             # median value of data set
    @data_set   = Array.new                     # start with empty data set
  end

  attr_reader :start, :end, :bin_size, :num_bins, :median

  def [](index)
    @histo[index]
  end

  def h
    @histo
  end
  
  def median
    @data_set.sort[@data_set.size/2]
  end
  
  def top_quartile
    @data_set.sort[-@data_set.size/4]
  end
  
  def bottom_quartile
    @data_set.sort[@data_set.size/4]
  end

  def add_data(element)   
    if element < @start
      @bucket = 0
    elsif element > @end
      @bucket = -1
    else
      @bucket = (element-@start)/@bin_size + 1
    end
    @histo[@bucket.to_i] += 1
    
    # Add element to a data set -- need this to calculate median
    @data_set << element
  end

end