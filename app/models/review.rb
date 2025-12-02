class Review < ActiveRecord::Base

  validates :rating, numericality: { 
    greater_than_or_equal_to: 0, 
    less_than_or_equal_to: 10,
    message: "must be between 0 and 10"
  }
  validates :reviewer, inclusion: { in: %w[client vendor] }
  validate :reviewed_person_must_exist


  def self.vendor_reviews(vendor_id)
    where(vendor_id: vendor_id, reviewer: 'client')
  end

  def self.client_reviews(client_id)
    where(client_id: client_id, reviewer: 'vendor')
  end


  def self.ransackable_attributes(auth_object = nil)
    %w[
      id client_id client_name comment created_at rating reviewer title updated_at vendor_id vendor_name
    ]
  end


  def self.ransackable_associations(auth_object = nil)
    []
  end

  private


  def reviewed_person_must_exist
    if reviewer == 'client'
      errors.add(:vendor_name, "Vendor not found") unless UserAccount.exists?(name: vendor_name)
    elsif reviewer == 'vendor'
      errors.add(:client_name, "Client not found") unless UserAccount.exists?(name: client_name)
    end
  end
end
