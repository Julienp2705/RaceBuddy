def race_category_label(distance)
  case distance
  when 0..10 then "Courte"
  when 10..21 then "Moyenne"
  when 21..42 then "Longue"
  else "Ultra"
  end
end

  def race_category_image(distance)
    seed = race_category_label(distance).parameterize
    "https://picsum.photos/seed/#{seed}/400/220"

  # category = race_category_label(distance){
  #  "Courte"  => "https://res.cloudinary.com/en57d7v3/image/upload/v.../courte.jpg",
  #  "Moyenne" => "https://res.cloudinary.com/en57d7v3/image/upload/v.../moyenne.jpg",
  #  "Longue"  => "https://res.cloudinary.com/en57d7v3/image/upload/v.../longue.jpg",
  #  "Ultra"   => "https://res.cloudinary.com/en57d7v3/image/upload/v.../ultra.jpg"
  # }
  # [category]
  end
