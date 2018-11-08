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
    thumbnail: "http://keenthemes.com/assets/bootsnipp/k1.jpg",
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
    video_url: "http://res.cloudinary.com/olalalala/video/upload/v1541637860/flgmnhf4lbolzwe9ec6j.mp4",
    course_id: 1
  )
end
