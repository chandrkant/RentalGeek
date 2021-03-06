class DeviseCreatePropertyManagers < ActiveRecord::Migration
  def change
    create_table(:property_managers) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps
      
      #########################################################################
      
      t.string  :name, :null => false
      
      t.integer :rentalgeek_id, :null => false
      
      t.string  :customer_contact_email_address
      t.integer :customer_contact_phone_number, :limit => 8 # PostgreSQL 'bigint' size
      
      t.boolean :accepts_cash                 , :null => false, :default => true
      t.boolean :accepts_checks               , :null => false, :default => true
      t.boolean :accepts_credit_cards_offline , :null => false, :default => false
      t.boolean :accepts_online_payments      , :null => false, :default => false
    end

    add_index :property_managers, :email,                :unique => true
    add_index :property_managers, :reset_password_token, :unique => true
    # add_index :property_managers, :confirmation_token,   :unique => true
    # add_index :property_managers, :unlock_token,         :unique => true
    
    ############################################################################
    
    add_index :property_managers, :name         , :unique => true    
    add_index :property_managers, :rentalgeek_id, :unique => true
  end
end

