# Destroy everything

unless Rails.env.production?
  User.destroy_all
  Ethnicity.destroy_all
  Message.destroy_all
end

Ethnicity.create([
  { name: 'African / Black' },
  { name: 'Asian' },
  { name: 'Latino' },
  { name: 'Indian' },
  { name: 'White' },
])

@images = [
  File.open('/users/Shared/sample1.jpg'),
  File.open('/users/Shared/sample2.jpg'),
  File.open('/users/Shared/sample3.jpg'),
  File.open('/users/Shared/sample4.jpg'),
  File.open('/users/Shared/sample5.jpg'),
  File.open('/users/Shared/sample6.jpg'),
  File.open('/users/Shared/sample7.jpg'),
  File.open('/users/Shared/sample8.jpg'),
  File.open('/users/Shared/sample9.jpg'),
  File.open('/users/Shared/sample10.jpg'),
  File.open('/users/Shared/sample11.jpg'),
  File.open('/users/Shared/sample12.jpg'),
  File.open('/users/Shared/sample13.jpg'),
  File.open('/users/Shared/sample14.jpg'),
  File.open('/users/Shared/sample15.jpg'),
  File.open('/users/Shared/sample16.jpg'),
  File.open('/users/Shared/sample17.jpg'),
  File.open('/users/Shared/sample18.jpg'),
  File.open('/users/Shared/sample19.jpg')
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
  self_summary:   "I'm a personable, open-minded guy who is finding his footing in the gay community, looking for interesting experiences, and burying his head in a textbook at a venue near you!\n\nI have a wide range of interests, which may include (but is not limited to) cool stuff that you like™... so message me about absolutely anything. We can make a conversation out of it.\n\nI'm also here to go on dates and bob for apples. And I'm all out of apples.",
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
@user1.profile_photos << ProfilePhoto.new(photo_object: @images.sample)
@user1.profile_photos << ProfilePhoto.new(photo_object: @images.sample)
@user1.profile_photos << ProfilePhoto.new(photo_object: @images.sample)



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
@user2.profile_photos << ProfilePhoto.new(photo_object: @images.sample)


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
  num_of_kids:    2,
  body_type:      "A few extra pounds",
  smoking:        "Yes",
  drinking:       "Socially",
  religion:       "Jewish",
  education:      "Graduate School",
  work_industry:  "Radio Personality",
  wants_kids:     "Yes"
})
@user3.profile_photos << ProfilePhoto.new(photo_object: @images.sample)
@user3.profile_photos << ProfilePhoto.new(photo_object: @images.sample)

@user4 = User.create({
  first_name:     'Jesusa',
  last_name:      'L',
  display_name:   'Jesus_is_coming_xxx',
  email:          'jc@gmail.com',
  password:       'wootage1',
  sex:            'female',
  role:           'dater',
  birthdate:      18.years.ago,
  country:        'Canada',
  city:           'Scarborough',
  state:          'Ontario',
  postal_code:    'M1W 2T0',
  self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.",
  num_of_kids:    2,
  body_type:      "Voluptuous",
  smoking:        "Never",
  drinking:       "Never",
  religion:       "Christian",
  education:      "Some College",
  work_industry:  "University",
  wants_kids:     "Maybe"
})
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample)
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample)
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample)
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample)
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample)
@user4.profile_photos << ProfilePhoto.new(photo_object: @images.sample)


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