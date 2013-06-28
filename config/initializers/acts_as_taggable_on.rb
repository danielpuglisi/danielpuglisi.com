ActsAsTaggableOn::Tag.class_eval do
  extend FriendlyId
  friendly_id :name,
              use: :slugged,
              reserved_words: ['show', 'edit', 'create', 'update', 'destroy']
end

ActsAsTaggableOn.force_lowercase = true
