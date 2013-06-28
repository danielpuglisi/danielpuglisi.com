require 'test_helper'

class BrowseArticlesTest < ActionDispatch::IntegrationTest

  test "should return articles in recent order" do
    create(:post, title: "A productivity post", published_at: "2013-06-27")
    create(:post, title: "A programming post", published_at: "2013-06-28")
    visit articles_path
    assert_equal ["A programming post", "A productivity post"], all(".entry header h2").map(&:text)
  end
end
