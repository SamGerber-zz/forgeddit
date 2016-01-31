# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author, :subs, presence: true

  has_many :postings,
    class_name: "PostSub",
    foreign_key: :post_id,
    dependent: :destroy,
    inverse_of: :post

  has_many :subs,
    through: :postings,
    source: :sub

  has_many :moderators,
    through: :subs,
    source: :moderator

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id
end
