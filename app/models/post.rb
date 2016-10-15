class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  after_create :remake_slug

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end

  def remake_slug
    self.update_attribute(:slug, nil)
    self.save!
  end

  #You don't necessarily need this bit, but I have it in there anyways
  def should_generate_new_friendly_id?
    new_record? || self.slug.nil?
  end

  has_many :taggings
  has_many :tags, through: :taggings
  
  validates_presence_of :author,:title, :content, :all_tags

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip.capitalize).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.search(search_query)
    where(['content LIKE ?', "%#{search_query}%"])
  end
end
