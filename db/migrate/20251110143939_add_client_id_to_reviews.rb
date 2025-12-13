class AddClientIdToReviews < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:reviews, :client_id)
      add_column :reviews, :client_id, :integer
    end
  end
end
