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

@user1 = User.create({
  first_name:   'Josh',
  last_name:    'James',
  display_name: 'Joshua V',
  email:        'joshwcomeau@gmail.com',
  password:     'wootage1',
  sex:          'male',
  role:         'dater',
  birthdate:    28.years.ago
})

@user2 = User.create({
  first_name: 'Tina',
  last_name:  'Fey',
  display_name: 'Teefay',
  email:      'tina@gmail.com',
  password:   'wootage1',
  sex:        'female',
  role:       'dater',
  birthdate:  21.years.ago
})

@user3 = User.create({
  first_name: 'Dan',
  last_name:  'Carlin',
  display_name: 'CarlinMan1337',
  email:      'dan@gmail.com',
  password:   'wootage1',
  sex:        'male',
  role:       'dater',
  birthdate:  48.years.ago
})

@user4 = User.create({
  first_name: 'Jesusa',
  last_name:  'L',
  display_name: 'Jesus_is_coming_xxx',
  email:      'jc@gmail.com',
  password:   'wootage1',
  sex:        'female',
  role:       'dater',
  birthdate:  18.years.ago
})

@concierge1 = User.create({
  first_name: 'Miss',
  last_name:  'Manager',
  display_name: 'MissManagurrr',
  email:      'concierge@gmail.com',
  password:   'wootage1',
  sex:        'female',
  role:       'concierge'
})

@user1.profile_photos << ProfilePhoto.create
@user2.profile_photos << ProfilePhoto.create
@user3.profile_photos << ProfilePhoto.create
@user4.profile_photos << ProfilePhoto.create
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