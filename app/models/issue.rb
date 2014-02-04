class Issue < ActiveRecord::Base
  validates :number, uniqueness: true

  scope :published, -> { where(published: true) }

  has_many :links
  accepts_nested_attributes_for :links, allow_destroy: true

  after_create do
    unless body.present?
      update(body: <<EOF
Welcome to Friday is Webday ##{number}.

### Articles

{% links #{number}, article %}

### Demos and Code

{% links #{number}, demo %}

### Libraries and Tools

{% links #{number}, library %}
{% links #{number}, tool %}

### Inspirations and Useful Stuff

{% links #{number}, inspiration %}

Found something useful? Give me a hand and share it with your friends and followers.

If you have any cool project you would like to see in one of the next issues hit the reply button and show me what you got.

Daniel
EOF
      )
    end
  end
end
