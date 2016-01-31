# == Schema Information
#
# Table name: posts_subs
#
#  id         :integer          not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ActiveRecord::Base
  self.table_name = "posts_subs"
  validates :post, :sub, presence: true
  validates :post, uniqueness: { scope: :sub, message: "should not be posted to the same sub more than once" }

  belongs_to :sub,
    inverse_of: :postings

  belongs_to :post,
    inverse_of: :postings
end
