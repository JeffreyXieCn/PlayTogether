# == Schema Information
#
# Table name: clubs
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Club < ApplicationRecord # TODO: add club picture and club address
  has_many :members, dependent: :destroy # only a member of a club can see the info of other club members
  has_many :activities # a login in user can see all the activities of a club
  validates :name,  presence: true, length: { maximum: 50 }

end
