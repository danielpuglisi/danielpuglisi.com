FactoryGirl.define do
  factory :post do
    title "An awesome blog post"
    content "A long text"
    style :post
    published true
    published_at "2013-06-28".to_date
  end
end
