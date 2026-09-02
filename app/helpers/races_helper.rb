def race_category_label(distance)
  case distance
  when 0..10 then "Courte"
  when 10..21 then "Moyenne"
  when 21..42 then "Longue"
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
    "safety"    => "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmedia.istockphoto.com%2Fid%2F936492722%2Fphoto%2Ffar-play.jpg%3Fs%3D612x612%26w%3D0%26k%3D20%26c%3DT3o_qKn8b1Og-yp04NEeXJJu4PRhLUjpmoKS3Cf468U%3D&f=1&nofb=1&ipt=d89d10fbacd817b301c61e0327fdf39067f9bab127cf1d8093cc2ec7e5f4db71",
    "injury"    => "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimages.squarespace-cdn.com%2Fcontent%2Fv1%2F55b7f4ffe4b0a286c4c3499e%2F9030b28c-d59c-4f02-9527-f407a30de90d%2Fcommon-running-injuries&f=1&nofb=1&ipt=715df990e795aad8f283d4f00dc08f93da7d524eed7b18ffa8163c3756cc5a50",
    "nutrition" => "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fnutritiongeeks.com%2Fwp-content%2Fuploads%2F2025%2F12%2Fnutrition-for-marathon-runners-runner-nutrition.jpg&f=1&nofb=1&ipt=27dc8a28c9777e3e246fd4fec008e36c91311a627ef6aae81128a1df565e4a11"
  }[id]
end
