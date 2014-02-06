class AddDeliciousIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :delicious_id, :string, unique: true
  end
end
