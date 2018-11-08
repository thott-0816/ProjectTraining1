module HomeHelper
  def rate average, course_id=nil
    str = ""
    check_rate = !course_id.nil? && !current_user.check_rating?(course_id)
    1.upto(5) do |i|
      star = "<span class=\"glyphicon glyphicon-star %s\" data-value=#{i}></span>"
      status = ""

      if i <= average
        status = ""
      elsif (average.to_f - average.to_i).abs > 0 && average.ceil == i
        status = "half"
      else
        status = "uncheck"
      end
      status << " select_rate" if check_rate
      str += star % [].push(status)
    end
    str
  end

  def upto_item index, courses_size
    (index * 4 + 3) >= courses_size ? courses_size - 1 : (index * 4 + 3)
  end
end
