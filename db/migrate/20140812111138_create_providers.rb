class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :uid
      t.string :providers

      t.timestamps
    end
  end
end
