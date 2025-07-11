class Shift < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 0, confirmed: 1 } # 例：未確定:0, 確定:1
  validates :start_time, presence: true
end
