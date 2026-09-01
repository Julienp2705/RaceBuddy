def race_category_label(distance)
  case distance
  when 0..10 then "Courte"
  when 10..21 then "Moyenne"
  when 21..42 then "Longue"
  else "Ultra"
  end
end
