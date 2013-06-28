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

  test "archive should return articles by months" do
    create(:post, title: "April", published_at: "2013-04-01")
    create(:post, title: "June", published_at: "2013-06-01")
    visit archive_path
    assert_equal ["June, 2013", "April, 2013"], all(".entry header h2").map(&:text)
    assert_equal ["June", "April"], all(".entry-title").map(&:text)
  end

  test "should return post style" do
    post = create(:post, title: "This is a Post", style: :post)
    visit post_path(id: post)
    has_css?("entry post")
  end

  test "should return link style" do
    post = create(:post, title: "This is a Post", style: :link)
    visit post_path(id: post)
    has_css?("entry link")
  end
end
