# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  amount     :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_payments_on_member_id  (member_id)
#

class Payment < ApplicationRecord
  belongs_to :member
  # TODO Add functionality to show payment history, sort by date or clubs
end
