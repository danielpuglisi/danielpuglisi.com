require 'test_helper'

class BrowseArticlesTest < ActionDispatch::IntegrationTest

  test "should return articles in recent order" do
    create(:post, title: "A productivity post", published_at: "2013-06-27")
    create(:post, title: "A programming post", published_at: "2013-06-28")
    visit articles_path
    assert_equal ["A programming post", "A productivity post"], all(".entry header h2").map(&:text)
  end

  test "should return article when header is clicked" do
    post = create(:post, title: "Hepper jepper")
    visit articles_path
    click_link "Hepper jepper"
    assert_equal "Hepper jepper", find(".entry header h2").text
    assert_equal post_path(year: post.published_at.year, month: post.published_at.strftime("%m"), id: post), current_path
  end
end
