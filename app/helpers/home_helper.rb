module HomeHelper
  def rate average
    str = ""
    1.upto(5) do |i|
      if i <= average
        str += "<span class=\"glyphicon glyphicon-star\"></span>"
      elsif (average.to_f - average.to_i).abs > 0 && average.ceil == i
        str += "<span class=\"glyphicon glyphicon-star half\"></span>"        
      else
        str += "<span class=\"glyphicon glyphicon-star uncheck\"></span>"
      end
    end
    str
  end

  def upto_item index, courses_size
    (index * 4 + 3) >= courses_size ? courses_size - 1 : (index * 4 + 3)
  end
end
