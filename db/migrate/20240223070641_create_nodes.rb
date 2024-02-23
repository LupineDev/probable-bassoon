class CreateNodes < ActiveRecord::Migration[7.1]
  def change
    create_table :nodes do |t|
      t.bigint :parent_id
    end

    add_index :nodes, [:parent_id, :id]
  end
end
