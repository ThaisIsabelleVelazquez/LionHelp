class CreateServiceRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :service_requests do |t|
      t.references :client, foreign_key: { to_table: :user_accounts }
      t.references :vendor, foreign_key: { to_table: :user_accounts }
      t.references :service, foreign_key: true
      t.string :status
      t.text :message

      t.timestamps
    end
  end
end