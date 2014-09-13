namespace :db do
  namespace :export do
    task :fiw => :environment do
      issues = Issue.all
      output = Hash.from_xml(issues.to_xml :include => {:links => {:include => :tags}}).to_yaml
      # output = ""
      # issues.each do |issue|
      #   output += Hash.from_xml(issue.to_xml :include => {:links => {:include => {:taggings  => {:include => :tag}}}}).to_yaml
      # end
      File.open("tmp/fiw.yml", "w+") do |f|
        f.write(output)
      end
    end
  end
end
