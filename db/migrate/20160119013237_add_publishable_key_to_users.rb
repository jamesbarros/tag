class AddPublishableKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_token_type, :string
    add_column :users, :stripe_scope, :string
    add_column :users, :stripe_authorization_code, :string
    add_column :users, :stripe_oauth_error, :string
    add_column :users, :stripe_oauth_error_description, :string
  end
end
