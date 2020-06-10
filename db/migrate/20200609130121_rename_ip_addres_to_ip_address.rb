class RenameIpAddresToIpAddress < ActiveRecord::Migration[6.0]
  def change
    rename_column :activity_logs, :ip_addres, :ip_address
  end
end
