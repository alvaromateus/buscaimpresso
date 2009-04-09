class CreateTipos < ActiveRecord::Migration
  def self.up
   create_table :tipos do |t|
      t.column :descricao, :string, :limit => 30
      t.column :obs, :string, :limit => 150
    end
  end

  def self.down
    drop_table :tipos
  end
end
