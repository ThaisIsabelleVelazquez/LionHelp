class AddVendorIdToServices < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:services, :vendor_id)
      add_column :services, :vendor_id, :integer
    end
  end
end
