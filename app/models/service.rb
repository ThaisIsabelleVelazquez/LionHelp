class Service < ActiveRecord::Base
  validates :title, :description, :vendor_name, :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }


  BASE_CATEGORIES = [
    "Tutoring",
    "Food",
    "Cleaning",
    "Transportation",
    "Tech Help",
    "Other"
  ]

  # A category becomes official only after >= 3 uses
  CATEGORY_THRESHOLD = 3

  # Dropdowns only show OFFICIAL categories
  def self.available_categories
    BASE_CATEGORIES.sort
  end

  # Promote category if it appears enough times
  def self.detect_and_add_category!(category_name)
    return if BASE_CATEGORIES.include?(category_name)

    count = Service.where(category: category_name).count

    if count >= CATEGORY_THRESHOLD
      BASE_CATEGORIES << category_name
    end
  end
end