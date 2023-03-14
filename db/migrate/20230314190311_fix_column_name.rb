class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :foods, :measurement_unit, :unit
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
