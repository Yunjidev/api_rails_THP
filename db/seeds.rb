require 'faker'

User.delete_all
Article.delete_all

10.times do |i|
    firstname = Faker::Name.first_name
    User.create!(
        email: "#{firstname}.#{i}@yopmail.com",
        password: 'password',
        password_confirmation: 'password',
    )
end

30.times do |i|
    Article.create!(
        title: Faker::TvShows::RickAndMorty.quote,
        content: Faker::Lorem.paragraph(sentence_count: 15),
        user_id: User.last.id,
        private: false
    )
end