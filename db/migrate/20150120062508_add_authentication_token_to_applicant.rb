class AddAuthenticationTokenToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :authentication_token, :string
  end
end
