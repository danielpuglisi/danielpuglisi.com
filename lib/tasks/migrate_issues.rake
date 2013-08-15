namespace :migrate do
  task :issues => :environment do

    date = "2013-07-05".to_date
    8.times do |i|
      i = i + 1
      Issue.create(number: i, published_at: date + (7 * (i-1)).day)
    end

  end
end
