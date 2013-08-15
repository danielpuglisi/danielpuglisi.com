namespace :migrate do
  task :links => :environment do

    Issue.find_each do |issue|
      issue.links.each_with_index do |link, i|
        link.issue_order_position = i
        link.save
      end
    end
  end
end
