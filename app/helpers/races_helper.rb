module RacesHelper
  def race_category_label(distance)
    case distance
    when 0...10 then "Courte"
    when 10...21.1 then "Moyenne"
    when 21.1...42.2 then "Longue"
    else "Ultra"
    end
  end
end
