class CreateCeps < ActiveRecord::Migration
  def self.up
    create_table :ceps do |t|
      t.column :cep, :integer
      t.column :logradouro, :string, :limit => 60
      t.column :tipo_logradouro, :string, :limit => 20
      t.column :bairro, :string, :limit => 30
      t.column :cidade, :string, :limit => 30
      t.column :uf, :string, :limit => 2
    end
  end

  def self.down
    drop_table :ceps
  end
end
