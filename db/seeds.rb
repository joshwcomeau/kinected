# Destroy everything

unless Rails.env.production?
  User.destroy_all
  Ethnicity.destroy_all
  Message.destroy_all
end

IMG_LOCATION = Rails.env.production? ? '/home/app/app/current/app/assets/images/samples/' : '/users/Shared/'

Ethnicity.create([
  { name: 'African / Black' },
  { name: 'Asian' },
  { name: 'Latino' },
  { name: 'Indian' },
  { name: 'White' },
])

@images = [
  File.open("#{IMG_LOCATION}/sample1.jpg"),
  File.open("#{IMG_LOCATION}/sample2.jpg"),
  File.open("#{IMG_LOCATION}/sample3.jpg"),
  File.open("#{IMG_LOCATION}/sample4.jpg"),
  File.open("#{IMG_LOCATION}/sample5.jpg"),
  File.open("#{IMG_LOCATION}/sample6.jpg"),
  File.open("#{IMG_LOCATION}/sample7.jpg"),
  File.open("#{IMG_LOCATION}/sample8.jpg"),
  File.open("#{IMG_LOCATION}/sample9.jpg"),
  File.open("#{IMG_LOCATION}/sample10.jpg"),
  File.open("#{IMG_LOCATION}/sample11.jpg"),
  File.open("#{IMG_LOCATION}/sample12.jpg"),
  File.open("#{IMG_LOCATION}/sample13.jpg"),
  File.open("#{IMG_LOCATION}/sample14.jpg"),
  File.open("#{IMG_LOCATION}/sample15.jpg"),
  File.open("#{IMG_LOCATION}/sample16.jpg"),
  File.open("#{IMG_LOCATION}/sample17.jpg"),
  File.open("#{IMG_LOCATION}/sample18.jpg"),
  File.open("#{IMG_LOCATION}/sample19.jpg")
]

@user1 = User.create({
  first_name:     'Josh',
  last_name:      'V',
  display_name:   'Joshua V',
  email:          'joshwcomeau@gmail.com',
  password:       'wootage1',
  sex:            'male',
  role:           'dater',
  birthdate:      28.years.ago,
  country:        'Canada',
  city:           'Mississauga',
  state:          'Ontario',
  postal_code:    'L8P 2R4',
  self_summary:   "What is one even supposed to write in these things? I'm an ENFP, hoping to find an INFJ, though I'm open to meeting anyone with common interests.\nI suppose I should mention that I'm looking for someone to spend time with and get to know over time. I'm coming out of a long-term relationship so I'm not ready for big commitments right now, but I'm not into flings either...complicated =__=\nLet me just put the worst of me out there. I'm insecure about myself, more so than the average person. I have a temper and sometimes I scare myself. I can be bossy and very convincing when I argue. I can also be a sore loser. However, I will usually realise my mistakes (hindsight is always 20/20) and apologise. Another thing about me is that once I like someone, I am fiercely loyal and loving.\nI probably shouldn't even be on this site because of the emotional wreck I am right now, but I just need to feel like there are actual human people out there who want to meet me. Maybe one of them will stay and not abandon me...sad, right?",
  height:         188,
  num_of_kids:    0,
  body_type:      "Average",
  smoking:        "Never",
  drinking:       "Socially",
  religion:       "Atheist",
  education:      "Some College",
  work_industry:  "Software Developer",
  wants_kids:     "No"
})
@user1.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user1.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user1.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')



@user2 = User.create({
  first_name:     'Tina',
  last_name:      'Fey',
  display_name:   'Teefay',
  email:          'tina@gmail.com',
  password:       'wootage1',
  sex:            'female',
  role:           'dater',
  birthdate:      21.years.ago,
  country:        'Canada',
  city:           'Toronto',
  state:          'Ontario',
  postal_code:    'M5V 0C2',
  self_summary:   "Traveller when the time/money are right\nAmateur photographer\nFrequent runner\nTerrible but eager tennis player\nModerately fluent speaker of French\nMedical student at U of T",
  height:         143,
  num_of_kids:    0,
  body_type:      "Slender",
  smoking:        "Socially",
  drinking:       "Often",
  religion:       "Christian",
  education:      "High School",
  work_industry:  "Retail",
  wants_kids:     "Maybe"
})
@user2.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user2.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')


@user3 = User.create({
  first_name:     'Dan',
  last_name:      'Carlin',
  display_name:   'CarlinMan1337',
  email:          'dan@gmail.com',
  password:       'wootage1',
  sex:            'male',
  role:           'dater',
  birthdate:      48.years.ago,
  country:        'Canada',
  city:           'Scarborough',
  state:          'Ontario',  
  postal_code:    'M1P 4P0',
  self_summary:   "Taking life one step at a time.\nIt makes more sense to me to get to know each other more if we actually chat rather than filling these out, so just ask me. (:\nInstagram: mister_kayy\nTwitter: @Mister_kayy",
  height:         176,
  num_of_kids:    2,
  body_type:      "A few extra pounds",
  smoking:        "Yes",
  drinking:       "Socially",
  religion:       "Jewish",
  education:      "Graduate School",
  work_industry:  "Radio Personality",
  wants_kids:     "Yes"
})
@user3.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user3.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')

@user4 = User.create({
  first_name:     'Jesusa',
  last_name:      'L',
  display_name:   'Angelina Jolly',
  email:          'jc@gmail.com',
  password:       'wootage1',
  sex:            'female',
  role:           'dater',
  birthdate:      37.years.ago,
  country:        'Canada',
  city:           'London',
  state:          'Ontario',
  postal_code:    'M1W 2T0',
  self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.",
  height:         173,
  num_of_kids:    2,
  body_type:      "Voluptuous",
  smoking:        "Never",
  drinking:       "Never",
  religion:       "Christian",
  education:      "Some College",
  work_industry:  "University",
  wants_kids:     "Maybe"
})
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')


@filler_user1 = User.create({
  first_name:     'Lorraine',
  last_name:      'L',
  display_name:   'Strawbessa Bella Fontaine',
  email:          "sbf@gmail.com",
  password:       'wootage1',
  sex:            'female',
  role:           'dater',
  birthdate:      22.years.ago,
  country:        'Canada',
  city:           'Toronto',
  state:          'Ontario',
  postal_code:    'M1W 2T0',
  self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.",
  height:         123,
  num_of_kids:    2,
  body_type:      "Voluptuous",
  smoking:        "Never",
  drinking:       "Never",
  religion:       "Christian",
  education:      "Some College",
  work_industry:  "University",
  wants_kids:     "Maybe"
})
@filler_user1.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filler_user1.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')


@filler_user2 = User.create({
  first_name:     'Lorraine',
  last_name:      'L',
  display_name:   'xXx_FemmeFatale_xXx',
  email:          "fff@gmail.com",
  password:       'wootage1',
  sex:            'female',
  role:           'dater',
  birthdate:      19.years.ago,
  country:        'Canada',
  city:           'Toronto',
  state:          'Ontario',
  postal_code:    'M1W 2T0',
  self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.",
  height:         191,
  num_of_kids:    2,
  body_type:      "Voluptuous",
  smoking:        "Never",
  drinking:       "Never",
  religion:       "Christian",
  education:      "Some College",
  work_industry:  "University",
  wants_kids:     "Maybe"
})
@filler_user2.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filler_user2.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')

@filler_user3 = User.create({
  first_name:     'Lorraine',
  last_name:      'L',
  display_name:   'CandyWires',
  email:          "ccw@gmail.com",
  password:       'wootage1',
  sex:            'female',
  role:           'dater',
  birthdate:      31.years.ago,
  country:        'Canada',
  city:           'Toronto',
  state:          'Ontario',
  postal_code:    'M1W 2T0',
  self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.",
  height:         131,
  num_of_kids:    2,
  body_type:      "Voluptuous",
  smoking:        "Never",
  drinking:       "Never",
  religion:       "Christian",
  education:      "Some College",
  work_industry:  "University",
  wants_kids:     "Maybe"
})
@filler_user3.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filler_user3.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')



User.daters.each do |u|
  [1,3].sample.times do
    u.ethnicities << Ethnicity.all.sample
  end
end

@concierge1 = User.create({
  first_name: 'Miss',
  last_name:  'Manager',
  display_name: 'MissManagurrr',
  email:      'concierge@gmail.com',
  password:   'wootage1',
  sex:        'female',
  role:       'concierge'
})

@concierge1.profile_photos << ProfilePhoto.create

# Let's make some messages
Message.create([
  {
    user_id:      @user3.id,
    recipient_id: @user1.id,
    body:         'Howdy Partner.'
  },
  {
    user_id:      @user1.id,
    recipient_id: @user2.id,
    body:         'Hi TIna, I loved you on that TV show.'
  },
  {
    user_id:      @user4.id,
    recipient_id: @user1.id,
    body:         'No Parla Englesia'
  },
  {
    user_id:      @user3.id,
    recipient_id: @user4.id,
    body:         'Salutationa'
  }
])