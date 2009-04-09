class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.column :nome, :string, :limit => 30
      t.column :login, :string, :limit => 10
      t.column :senha, :string, :limit => 8
      t.column :fone, :string, :limit => 15
      t.column :email, :string, :limit => 50
      t.column :complemento, :string, :limit =>20
      t.column :data_cadastro, :date
      # chave estrangeira
      t.column :cep_id, :integer
    end
  end

  def self.down
    drop_table :usuarios
  end
end
