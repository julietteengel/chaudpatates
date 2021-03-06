# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Training.destroy_all
Booking.destroy_all
Order.destroy_all
Location.destroy_all
City.destroy_all
User.destroy_all
Session.destroy_all
TicketsPackage.destroy_all
Plan.destroy_all

usain = User.create!(
  email: "usain@mail.com",
  password: "usainbolt",
  first_name: "Usain",
  last_name: "Bolt",
  photo: Cloudinary::Uploader.upload("http://www.buzzdefou.com/wp-content/uploads/2016/08/usain_bolt-1250x750.jpg")
  )

kenenisa = User.create!(
  email: "kenenisa@mail.com",
  password: "kenenisa",
  first_name: "Kenenisa",
  last_name: "Bekele",
  is_coach: true,
  photo: Cloudinary::Uploader.upload("https://upload.wikimedia.org/wikipedia/commons/4/4a/Kenenisa_Bekele_Berlin_2009.jpg")
  )

paul = User.create!(
  email: "pv.frequencesport@gmail.com",
  password: "Campolo52!",
  first_name: "Paul",
  last_name: "Voillemin",
  is_coach: true,
  photo: Cloudinary::Uploader.upload("https://pbs.twimg.com/profile_images/522401288848302081/d8CfHnPb.jpeg")
  )

paris = City.create!(
	name: "Paris",
	user_id: paul.id,
	photo: Cloudinary::Uploader.upload("https://a4.odistatic.net/images/landingpages/vacation/640x480/paris_640x480.jpg")
	)

lyon = City.create!(
  name: "Lyon",
  user_id: paul.id,
  photo: Cloudinary::Uploader.upload("https://static.vueling.com/cms/media/1216826/lyon.jpg")
  )

lyon_first_session = Session.create!(
  day: 0,
  time_of_day: Time.new(2017, 05, 16, 19, 30, 0, "+02:00").strftime("%H:%M:%S"),
  city_id: lyon.id
  )

lyon_second_session = Session.create!(
  day: 2,
  time_of_day: Time.new(2017, 10, 18, 19, 30, 0, "+02:00").strftime("%H:%M:%S"),
  city_id: lyon.id
  )

paris_first_session = Session.create!(
	day: 0,
	time_of_day: Time.new(2017, 05, 16, 19, 30, 0, "+02:00").strftime("%H:%M:%S"),
	city_id: paris.id
	)

paris_second_session = Session.create!(
	day: 2,
	time_of_day: Time.new(2017, 10, 18, 19, 30, 0, "+02:00").strftime("%H:%M:%S"),
	city_id: paris.id
	)

training_fake = Training.create!(
  city_id: lyon.id,
  # public_description: "amazing fake training public",
  # private_description: "amazing fake training private",
  date: Time.new(2017, 10, 18, 19, 30, 0, "+02:00").strftime("%H:%M:%S")
  )

training_fake2 = Training.create!(
  city_id: lyon.id,
  # public_description: "amazing fake training public",
  # private_description: "amazing fake training private",
  date: Time.new(2017, 07, 18, 19, 30, 0, "+02:00").strftime("%H:%M:%S")
  )

training_fake3 = Training.create!(
  city_id: paris.id,
  # public_description: "amazing fake training public",
  # private_description: "amazing fake training private",
  date: Time.new(2017, 05, 05, 19, 30, 0, "+02:00").strftime("%H:%M:%S")
  )

training_fake4 = Training.create!(
  city_id: paris.id,
  # public_description: "amazing fake training public",
  # private_description: "amazing fake training private",
  date: Time.new(2017, 06, 05, 19, 30, 0, "+02:00").strftime("%H:%M:%S")
  )

# wednesday_session = Session.create!(
#   day: 2,
#   time_of_day: Time.new(2017, 10, 31, 19, 0, 0, "+02:00").strftime("%H:%M:%S"),
#   city_id: strasbourg.id
#   )

# thursday_session = Session.create!(
#   day: 3,
#   time_of_day: Time.new(2017, 10, 31, 19, 0, 0, "+02:00").strftime("%H:%M:%S"),
#   city_id: aix.id
#   )

le_wagon = Location.create!(
	name: "Le Wagon",
  private_description: "super desc",
  public_description: "super desc",
	address: "16 Villa Gaudelet, 75011 Paris",
	photo: Cloudinary::Uploader.upload("http://lewagon.github.io/ui-components/images/lewagon.png")
	)

belle_mai = Location.create!(
  name: "Belle de Mai",
  private_description: "super desc",
  public_description: "super desc",
  address: "37 Rue Guibal, 13003 Marseille",
  photo: Cloudinary::Uploader.upload("http://www.belledemai.org/wp-content/themes/rewalk-parent/default_media/logo-simple.png")
  )

ticket_by_10 = TicketsPackage.create!(
	sku: "ticket-training-by-10",
	price: 10,
	tickets_nb: 1
	)

Plan.create({
      name: 'Abonnement mensuel',
      price: 29.99,
      interval: 'month',
      # highlight: true,
      stripe_id: '3_months_subscription',
      features: ['Séances illimitées', 'Sans engagement'].join("\n\n"),
      display_order: 1
    })

    Plan.create({
      name: 'Abonnement annuel',
      price: 250.00,
      interval: 'year',
      stripe_id: '1_year_subscription',
      features: ['Un an de séances illimitées'].join("\n\n"),
      display_order: 2
    })

# plan1 = Plan.create(
#   :amount => 2400,
#   :interval => 'month',
#   :name => 'Abonnement mensuel',
#   :currency => 'eur',
#   :id => 'monthly'
# )

# Plan.create(name: plan.name, stripe_id: plan1.id, display_price: (plan.amount.to_f / 100))

# plan2 = Stripe::Plan.create(
#   :amount => 25000,
#   :interval => 'month',
#   :name => 'Abonnement annuel',
#   :currency => 'eur',
#   :id => 'yearly'
# )

# Plan.create(name: plan.name, stripe_id: plan2.id, display_price: (plan.amount.to_f / 100))

# p plan1
# p plan2
