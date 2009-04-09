class CreateVendedors < ActiveRecord::Migration
  def self.up
    create_table :vendedors do |t|
      t.column :nome, :string, :limit => 30
      t.column :fone, :string, :limit => 15
      t.column :email, :string, :limit => 50
      t.column :login, :string, :limit => 10
      t.column :senha, :string, :limit => 8
      t.column :comissao, :integer
      t.column :data_cadastro, :date
      #chave estrangeira
      t.column :empresa_id, :integer
    end
  end

  def self.down
    drop_table :vendedors
  end
end
