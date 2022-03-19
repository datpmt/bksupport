class AddStatusOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :status, :string, :default => 'pending'
    #Ex:- :default =>''
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
