class CreateBirds < ActiveRecord::Migration[7.1]
  def change
    create_table :birds do |t|
      t.bigint :node_id
    end

    add_index :birds, [:node_id, :id]
  end
end
