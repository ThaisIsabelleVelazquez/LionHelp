class AddVendorNameToServices < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:services, :vendor_name)
      add_column :services, :vendor_name, :string
    end
  end
end
