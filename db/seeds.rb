# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: 'TV Commedies')
Category.create(name: 'TV Drama')

Video.create(title: 'Family Guy', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', small_cover_url: 'covers/family_guy.jpg', large_cover_url: 'covers/family_guy_large.png', category_id: 1)
Video.create(title: 'Futurama', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', small_cover_url: 'covers/futurama.jpg', large_cover_url: 'covers/futurama_large.png', category_id: 1)
Video.create(title: 'Monk', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', small_cover_url: 'covers/monk.jpg', large_cover_url: 'covers/monk_large.jpg', category_id: 2)
Video.create(title: 'South Park', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', small_cover_url: 'covers/south_park.jpg', large_cover_url: 'covers/south_park_large.png', category_id: 1)

Video.create(title: 'Family Guy', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', small_cover_url: 'covers/family_guy.jpg', large_cover_url: 'covers/family_guy_large.png', category_id: 1)
Video.create(title: 'Futurama', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', small_cover_url: 'covers/futurama.jpg', large_cover_url: 'covers/futurama_large.png', category_id: 1)
Video.create(title: 'Monk', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', small_cover_url: 'covers/monk.jpg', large_cover_url: 'covers/monk_large.jpg', category_id: 2)
Video.create(title: 'South Park', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', small_cover_url: 'covers/south_park.jpg', large_cover_url: 'covers/south_park_large.png', category_id: 1)
Video.create(title: 'South Park', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', small_cover_url: 'covers/south_park.jpg', large_cover_url: 'covers/south_park_large.png', category_id: 1)

josias = User.create(full_name: "Josias M", password: "1234", email: "abc@abc.com")

Review.create(user: josias, video_id: 3, rating: 5, content: "This is a really good movie")
Review.create(user: josias, video_id: 3, rating: 2, content: "This is a horrible movie")