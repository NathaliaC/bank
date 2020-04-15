class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.decimal :balance
      t.string :account_number
      t.string :account_token

      t.timestamps
    end
  end
end
