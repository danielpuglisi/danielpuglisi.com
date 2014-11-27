require "#{Rails.root}/app/helpers/pages_helper"
# require "#{Rails.root}/config/initializers/liquid"
include PagesHelper
include Liquid
# include LinksRenderer
namespace :db do
  namespace :export do
    task :fiw => :environment do
      issues = Issue.all
      # output = Hash.from_xml(issues.to_xml :include => {:links => {:include => :tags}}).to_yaml
      # output = ""
      # issues.each do |issue|
      #   output += Hash.from_xml(issue.to_xml :include => {:links => {:include => {:taggings  => {:include => :tag}}}}).to_yaml
      # end
      # File.open("tmp/fiw.yml", "w+") do |f|
      #   f.write(output)
      # end
      issues.each do |issue|
        File.open("tmp/fiw_#{issue.number}_#{issue.published_at.to_s}.html", "w+") do |f|
          f.write(markdown(liquidize(issue.body)))
        end
      end
    end
  end
end
