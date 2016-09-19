class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings

  def self.tags
    select('name')
      .joins(:taggings)
      .group('taggings.tag_id')
      .order('name')
  end
end
