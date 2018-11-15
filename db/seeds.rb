User.create!(
  name: "admin",
  email: "admin@gmail.com",
  password: "123456",
  role: "admin",
  avatar: File.open(File.join(Rails.root, "app/assets/images/default_avatar_big.png"))
)

User.create!(
  name: "hihi",
  email: "user@gmail.com",
  password: "123456",
  role: "student",
  avatar: File.open(File.join(Rails.root, "app/assets/images/doremon.jpg"))
)

Category.create!(
  name: Faker::Name.name,
  parent_id: nil,
  description: Faker::Food.description
)

15.times do |i|
  rate = Faker::Number.decimal(1, 1).to_f
  if rate > 5
    rate -= 5
  end
  Course.create!(
    name: Faker::Name.name,
    description: Faker::Food.description,
    rate_average: rate,
    thumbnail: File.open(File.join(Rails.root, "app/assets/images/default.jpg")),
    user_id: 1,
    category_id: 1
)
end

10.times do |i|
  rate = [1,2,3,4,5].sample
  Rating.create!(
    rating: rate,
    user_id: 1,
    course_id: 1
)
end

10.times do |i|
  Comment.create!(
    content: Faker::Cat.registry,
    user_id: 1,
    course_id: 1,
    parent_id: i/3 == 0 ? nil : (i/3)*3
  )
end

5.times do |i|
  Lesson.create!(
    name: Faker::LeagueOfLegends.champion,
    video_url: File.open(File.join(Rails.root, "app/assets/images/video.mp4")),
    course_id: 1
  )
end
