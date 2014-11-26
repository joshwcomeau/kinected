# Destroy everything

unless Rails.env.production?
  
  
  Activity.destroy_all
  Answer.destroy_all
  Ethnicity.destroy_all
  Favorite.destroy_all
  Message.destroy_all
  Permission.destroy_all
  ProfilePhoto.destroy_all
  Question.destroy_all
  User.destroy_all

  # Reset all the IDs so we aren't perpetually climbing up, and some firebase data can persist between seedings.
  ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.reset_pk_sequence!(t) }

end

IMG_LOCATION = Rails.env.production? ? '/home/app/app/current/app/assets/images/samples/' : '/users/Shared/'

Ethnicity.create([
  { name: 'African / Black' },
  { name: 'Asian' },
  { name: 'Latino' },
  { name: 'Indian' },
  { name: 'White' },
])

Question.create([
  { body: 'If I had 24 hours left to live, I would...'},
  { body: 'I\'ve always wanted to...'},
  { body: 'If I could travel anywhere, I\'d go to...'},
  { body: 'I\'m really good at...'},
  { body: 'I\'m really bad at...'}
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
  self_summary:   "What is one even supposed to write in these things? I'm an ENFP, hoping to find an INFJ, though I'm open to meeting anyone with common interests.\n\nI suppose I should mention that I'm looking for someone to spend time with and get to know over time. I'm coming out of a long-term relationship so I'm not ready for big commitments right now, but I'm not into flings either...complicated =__=\n\nLet me just put the worst of me out there. I'm insecure about myself, more so than the average person. I have a temper and sometimes I scare myself. I can be bossy and very convincing when I argue. I can also be a sore loser. However, I will usually realise my mistakes (hindsight is always 20/20) and apologise. Another thing about me is that once I like someone, I am fiercely loyal and loving.\n\nI probably shouldn't even be on this site because of the emotional wreck I am right now, but I just need to feel like there are actual human people out there who want to meet me. Maybe one of them will stay and not abandon me...sad, right?",
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
  self_summary:   "Basically I love life and I love living life. I enjoy the outdoors, traveling, restaurants, laughing, goIng to cultural events, and sociaLizing with quality peOple. Its just better liVing and sharing lifE with someone else :)\n\nI’m originally from Australia, did my undergrad in Canada, and Have lived in a few different cOuNtries.\n\nI enjoy being active, healthy and Staying fit. FaMily and friends Are impoRtanT to me as well.\n\nIf you’d like to know more Say “hi”. I didn’t reveAl a lot about my Self for you to read on purpose. Rather we chat, talk, engage in conversation to get to know each other instead of us reading through a long page in this section about each other. Also, just because someone lookS like a good match “on paper”, doesn’t necessarilY translate in reality.",
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
  self_summary:   "Traveller when the time/money are right\n\nAmateur photographer\nFrequent runner\nTerrible but eager tennis player\nModerately fluent speaker of French\nMedical student at U of T\n\n\nChronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.",
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


@user5 = User.create({
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
@user5.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user5.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')


@user6 = User.create({
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
@user6.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user6.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')

@user7 = User.create({
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
@user7.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@user7.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')


# Filler users. No permissions or anything, just used for 'browse'
@filleruser1 = User.create({
  first_name:     'Thomas', last_name:      'Bangalter', display_name:   'DaftMan1337', email:          "tb@gmail.com", password:       'wootage1', sex:            'male', role:           'dater', birthdate:      24.years.ago, country:        'Canada', city:           'Toronto', state:          'Ontario', postal_code:    'M1W 2T0', self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.", height:         190, num_of_kids:    0, body_type:      "Voluptuous", smoking:        "Never", drinking:       "Never", religion:       "Christian", education:      "Some College", work_industry:  "University", wants_kids:     "Maybe"
})
@filleruser2 = User.create({
  first_name:     'Jeanine', last_name:      'Marosnes', display_name:   'Sw33tch33kz', email:          "jm@gmail.com", password:       'wootage1', sex:            'female', role:           'dater', birthdate:      19.years.ago, country:        'Canada', city:           'Toronto', state:          'Ontario', postal_code:    'M1W 2T0', self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.", height:         142, num_of_kids:    0, body_type:      "Thin", smoking:        "Never", drinking:       "Never", religion:       "Christian", education:      "Some College", work_industry:  "University", wants_kids:     "Maybe"
})
@filleruser3 = User.create({
  first_name:     'Susanne', last_name:      'DeMorres', display_name:    'CouponClip', email:          "sd@gmail.com", password:       'wootage1', sex:            'female', role:           'dater', birthdate:      51.years.ago, country:        'Canada', city:           'Toronto', state:          'Ontario', postal_code:    'M1W 2T0', self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.", height:         114, num_of_kids:    0, body_type:      "Voluptuous", smoking:        "Never", drinking:       "Never", religion:       "Christian", education:      "Some College", work_industry:  "University", wants_kids:     "Maybe"
})
@filleruser4 = User.create({
  first_name:     'Elizabeth', last_name:      'IV', display_name:   'QueenPrincess', email:          "eiv@gmail.com", password:       'wootage1', sex:            'female', role:           'dater', birthdate:      38.years.ago, country:        'Canada', city:           'Toronto', state:          'Ontario', postal_code:    'M1W 2T0', self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.", height:         144, num_of_kids:    0, body_type:      "Average", smoking:        "Never", drinking:       "Never", religion:       "Christian", education:      "Some College", work_industry:  "University", wants_kids:     "Maybe"
})
@filleruser1.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filleruser2.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filleruser2.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filleruser2.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filleruser3.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filleruser4.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filleruser4.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filleruser4.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')
@filleruser4.profile_photos << ProfilePhoto.new(photo_object: @images.sample, caption: 'This was Halloween 2027, right before the Thoraxians invaded ;) ^_^;;;')

# Add a user with no photos, she shouldnt show up anywhere.
@nophotogirl = User.create({
  first_name:     'Elizabeth', last_name:      'IV', display_name:   'NoPhotoGirl', email:          "npg@gmail.com", password:       'wootage1', sex:            'female', role:           'dater', birthdate:      38.years.ago, country:        'Canada', city:           'Toronto', state:          'Ontario', postal_code:    'M1W 2T0', self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.", height:         144, num_of_kids:    0, body_type:      "Average", smoking:        "Never", drinking:       "Never", religion:       "Christian", education:      "Some College", work_industry:  "University", wants_kids:     "Maybe"
})


# Let's add some blocked users.
@i_blocked_user1 = User.create({
  first_name:     'I blocked',
  last_name:      'you',
  display_name:   'I blocked you',
  email:          "ibu1@gmail.com",
  password:       'wootage1',
  sex:            'female',
  role:           'dater',
  birthdate:      31.years.ago,
  country:        'Canada',
  city:           'Toronto',
  state:          'Ontario',
  postal_code:    'M1W 2T0',
  self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.",
})

@user1_blocked_me = User.create({
  first_name:     'you blocked',
  last_name:      'me',
  display_name:   'You blocked me',
  email:          "u1bm@gmail.com",
  password:       'wootage1',
  sex:            'female',
  role:           'dater',
  birthdate:      32.years.ago,
  country:        'Canada',
  city:           'Toronto',
  state:          'Ontario',
  postal_code:    'M1W 2T0',
  self_summary:   "Chronologically, Metroid Prime 2: Echoes takes place fourth in the Metroid fictional universe. The story follows bounty hunter Samus Aran after she is sent to rescue Galactic Federation Marines from a ship near Aether, a planet inhabited by a race known as the Luminoth. There, she discovers that the troops were slaughtered by the Ing, a race that came from an alternate dimension of Aether. \n\nSamus must travel to three temples to ensure the destruction of the Ing, while battling Space Pirates and her mysterious doppelgänger called Dark Samus.",
})

@i_blocked_user1.permissions.create(target_user_id: @user1.id, status: 0)
@user1.permissions.create(target_user_id: @user1_blocked_me.id, status: 0)


@concierge1 = User.create({
  first_name: 'Miss',
  last_name:  'Manager',
  display_name: 'MissManagurrr',
  email:      'concierge@gmail.com',
  password:   'wootage1',
  sex:        'female',
  city:       'Toronto',
  birthdate:  23.years.ago,
  role:       'concierge'
})
@concierge1.profile_photos << ProfilePhoto.new(photo_object: @images.sample)


answers = [
  "I would spend time with the people most important to me.", 
  "go fishing. my dad would always go but he wouldnt take me",
  "I have always wanted to visit Paris.",
  "I'm the best pingpong player youve eer heard of. Won 15 straight matches in little pingpong league.",
  "I have no faults, I am a perfect specimen."
]

User.daters.each do |u|
  [1,3].sample.times do
    u.ethnicities << Ethnicity.all.sample
  end
  u.answers.create(question_id: Question.first.id,  body: answers.sample)
  u.answers.create(question_id: Question.second.id, body: answers.sample)
  u.answers.create(question_id: Question.third.id,  body: answers.sample)
  u.answers.create(question_id: Question.fourth.id, body: answers.sample)
  u.answers.create(question_id: Question.fifth.id,  body: answers.sample)

  u.update(concierge_id: @concierge1.id)
end


@admin = User.create({
  first_name: 'Admin',
  last_name:  'Istrator',
  display_name: 'Administrator',
  email:      'admin@gmail.com',
  password:   'wootage1',
  sex:        'male',
  role:       'admin'
})

# Let's make some messages, one of each status for our @user1
Message.create([
  # OUTBOX
  {         
    user_id:      @user1.id,
    recipient_id: @user2.id,
    body:         'Hi there. I really like your shoes! Have you ever been to the Shoe Museum??(O-0)',
    created_at:   2.5.hours.ago,
    status:       0
  },
  {
    user_id:      @user1.id,
    recipient_id: @user3.id,
    body:         'Hi wanna chat?(O-1)',
    created_at:   3.5.hours.ago,
    status:       1
  },
  {
    user_id:      @user1.id,
    recipient_id: @user4.id,
    body:         'Heyzz, I think your rly cute. Hit me back babz <3(O-2)',
    created_at:   4.5.hours.ago,
    status:       2
  },

  {
    user_id:      @user1.id,
    recipient_id: @user5.id,
    body:         'Why hello there! I dont know what it is but there is just something about brunettes. You look really good and I wanted to say that it was an honor to be on the same site as you.(O-4)',
    created_at:   6.5.hours.ago,
    status:       4
  },

  # INBOX
  # Rejected, so it should be invisible.  
  {
    user_id:      @user6.id,
    recipient_id: @user1.id,
    body:         'Hi.(I-4)',
    created_at:   6.hours.ago,
    status:       4
  },

  # Read, old news, but unresponded
  {
    user_id:      @user4.id,
    recipient_id: @user1.id,
    body:         'Hey are you in T.dot? I will be visiting 9/25 to 10/11.(I-2)',
    created_at:   4.hours.ago,
    status:       2
  },
  # Sent and unread. Should be green!
  {
    user_id:      @user2.id,
    recipient_id: @user1.id,
    body:         'I really like The Notebook too!!! We are soulmates.(I-1)',
    created_at:   3.hours.ago,
    status:       1
  },
  # Queued. Should not show up
  {         
    user_id:      @user3.id,
    recipient_id: @user1.id,
    body:         'You should\'t see me, Im queued.(I-0)',
    created_at:   2.hours.ago,
    status:       0
  },

  # Unrelated, to other users
  {
    user_id:      @user3.id,
    recipient_id: @user4.id,
    body:         'YOU SHOULDNT SEE ME. I belong to someone else.'
  }
])

# Accepted messages need to have the appropriate permission created as well
@accepted_message_1 = Message.create({
  user_id:      @user1.id,
  recipient_id: @user7.id,
  body:         'Hi babygirl. I heard this song on the radio I think you would like. It\'s called That Girl Is Mine ;)(O-3)',
  created_at:   5.5.hours.ago,
  status:       3
})
@accepted_message_2 = Message.create({
  user_id:      @user5.id,
  recipient_id: @user1.id,
  body:         'Hey mister, have you ever been with a black girl? I think I could show you a thing or two.(I-3)',
  created_at:   5.hours.ago,
  status:       3
})

@accepted_message_1.permissions.create({
  user_id: @user7.id,
  target_user_id: @user1.id,
  status: 1
})

@accepted_message_2.permissions.create({
  user_id: @user1.id,
  target_user_id: @user5.id,
  status: 1
})