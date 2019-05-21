# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :users do
      column :id, :uuid, primary_key: true, null: false
      column :email, :text
      column :first_name, :text
      column :last_name, :text
      column :encrypted_password, :text
      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false
    end
  end
end
