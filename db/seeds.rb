# Destroy everything

if Rails.env.production?
  User.destroy_all
  Ethnicity.destroy_all
end

Ethnicity.create([
  { name: 'African / Black' },
  { name: 'Asian' },
  { name: 'Latino' },
  { name: 'Indian' },
  { name: 'White' },
])