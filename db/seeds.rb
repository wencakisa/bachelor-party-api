# Users
users_credentials = [
  {
    email: 'admin@bps.bg',
    name: 'Admin',
    password: 'admin123',
    password_confirmation: 'admin123',
    role: :admin
  },
  {
    email: 'guide@bps.bg',
    name: 'Guide',
    password: 'guide123',
    password_confirmation: 'guide123',
    role: :guide
  },
  {
    email: 'customer@bps.bg',
    name: 'Customer',
    password: 'customer123',
    password_confirmation: 'customer123',
    role: :customer
  },
  {
    email: 'customer2@bps.bg',
    name: 'Customer2',
    password: 'customer123',
    password_confirmation: 'customer123',
    role: :customer
  }
]

users_credentials.each do |user_data|
  User.create!(**user_data)
end

# Activities (incl. prices)

activities_data = [
  {
    title: 'Karting',
    subtitle: 'Braap braap',
    details: 'Beautiful kart racing in the heart of the city',
    transfer_included: true,
    guide_included: true,
    duration: 2,
    time_type: :night,
    prices_attributes: [
      {
        amount: 23,
        options: '2x10min'
      },
      {
        amount: 48,
        options: '3x20min'
      }
    ]
  },
  {
    title: 'Paintball',
    subtitle: 'Fire in the hole',
    details: 'Try to shoot the bachelor with colorful bombs',
    guide_included: true,
    duration: 1,
    time_type: :day,
    prices_attributes: [
      {
        amount: 12,
        options: '20 balls'
      },
      {
        amount: 30,
        options: '50 balls'
      }
    ]
  },
  {
    title: 'Water Ski',
    subtitle: 'Ski, but in water',
    details: 'Compete with other bachelors and get the prizes',
    transfer_included: true,
    duration: 3,
    time_type: :day,
    prices_attributes: [
      {
        amount: 20
      }
    ]
  },
]

activities_data.each do |activity_data|
  Activity.create!(**activity_data)
end

# Quotations

quotations_data = [
  {
    group_size: 12,
    date: Date.parse('20-06-2019'),
    user_email: User.third.email,
    activities: Activity.all,
    prices: Activity.all.map(&:prices).map(&:first)
  },
  {
    group_size: 12,
    date: Date.parse('12-12-2019'),
    user_email: User.last.email,
    activities: [Activity.first, Activity.last],
    prices: [Activity.first, Activity.last].map(&:prices).map(&:last)
  }
]

quotations_data.each do |quotation_data|
  Quotation.create!(**quotation_data)
end
