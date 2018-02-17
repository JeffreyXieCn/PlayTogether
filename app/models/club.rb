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

class Club < ApplicationRecord
  has_many :members
  validates :name,  presence: true, length: { maximum: 50 }

  def club_admin?(user)

  end
end
