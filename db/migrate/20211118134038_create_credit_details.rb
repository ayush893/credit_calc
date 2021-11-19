class CreateCreditDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_details do |t|
      t.string :email
      t.string :pan_card
      t.integer :aadhar_no
      t.integer :bank_account_no
      t.string :bank_ifsc
      t.integer :balance_inflow
      t.integer :balance_outflow
      t.json :meta, :default => {}

      t.timestamps
    end
  end
end
