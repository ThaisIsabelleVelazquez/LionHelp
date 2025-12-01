class Service < ActiveRecord::Base

  validates :title, :description, :vendor_name, :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }


  def self.ransackable_attributes(auth_object = nil)
    %w[id title description vendor_name category price created_at updated_at]
  end


  def self.ransackable_associations(auth_object = nil)
    []
  end
end
