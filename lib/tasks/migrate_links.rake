namespace :migrate do
  task :links => :environment do

    Link.find_each do |link|
      link.issue_order_position = link.id
      link.save
    end
  end
end
