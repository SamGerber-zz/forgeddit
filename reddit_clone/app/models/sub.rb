# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :moderator_id

    has_many :postings,
      class_name: "PostSub",
      foreign_key: :sub_id,
      dependent: :destroy,
      inverse_of: :sub

    has_many :posts,
      through: :postings,
      source: :post
end
