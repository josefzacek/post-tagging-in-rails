class Post < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  
  validates_presence_of :author, :content, :all_tags

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
