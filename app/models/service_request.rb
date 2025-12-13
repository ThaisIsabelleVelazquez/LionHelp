class ServiceRequest < ApplicationRecord
  belongs_to :client, class_name: 'UserAccount'
  belongs_to :vendor, class_name: 'UserAccount'
  belongs_to :service

  STATUSES = %w[pending accepted declined].freeze
  validates :status, presence: true, inclusion: { in: STATUSES }
end
