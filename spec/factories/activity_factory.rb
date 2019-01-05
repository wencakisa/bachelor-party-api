FactoryBot.define do
  factory :activity do
    title     { 'Activity Title' }
    subtitle  { 'A brief info' }
    duration  { 2 }
    time_type { :day }
  end
end
