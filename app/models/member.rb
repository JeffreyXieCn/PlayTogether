# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  balance    :decimal(10, 2)   default(0.0)
#  admin      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  club_id    :integer
#
# Indexes
#
#  index_members_on_club_id              (club_id)
#  index_members_on_user_id              (user_id)
#  index_members_on_user_id_and_club_id  (user_id,club_id) UNIQUE
#

class Member < ApplicationRecord
  belongs_to :user
  belongs_to :club
  has_many :payment
end
