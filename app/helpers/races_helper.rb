module RacesHelper
  def race_category_label(distance)
    case distance
    when 0..10 then "Courte"
    when 10..22 then "Moyenne"
    when 22..59 then "Longue"
    else "Ultra"
    end
  end

  def race_category_image(distance)
    category = race_category_label(distance)
    {
    "Courte"  => "https://res.cloudinary.com/en57d7v3/image/upload/v1788335654/img-course-4.png",
    "Moyenne" => "https://res.cloudinary.com/en57d7v3/image/upload/v1788335654/img-course-3.png",
    "Longue"  => "https://res.cloudinary.com/en57d7v3/image/upload/v1788335652/img-course-2.png",
    "Ultra"   => "https://res.cloudinary.com/en57d7v3/image/upload/v1788335653/img-course-1.png",
    }[category]
  end

  def article_category_image(id)
    {
      "safety"    => "https://res.cloudinary.com/en57d7v3/image/upload/v1788359890/ChatGPT_Image_2_sept._2026_16_37_46.png",
      "injury"    => "https://res.cloudinary.com/en57d7v3/image/upload/v1788428659/blessures.jpg",
      "nutrition" => "https://res.cloudinary.com/en57d7v3/image/upload/v1788427894/nutrition.png"
    }[id]
  end
end
