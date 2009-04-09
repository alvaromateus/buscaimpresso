class CreateEmpresas < ActiveRecord::Migration
  def self.up
    create_table :empresas do |t|
      t.column :cnpj, :string, :limit => 14
      t.column :inscricao_estadual, :string, :limit => 50
      t.column :inscricao_municipal, :string, :limit => 50
      t.column :razao_social, :string, :limit => 50
      t.column :nome_fantasia, :string, :limit => 50
      t.column :login, :string, :limit => 10
      t.column :senha, :string, :limit => 8
      t.column :complemento, :string, :limit => 20
      t.column :telefone, :string, :limit => 15
      t.column :fax, :string, :limit => 15
      t.column :email, :string, :limit => 50
      t.column :homepage, :string, :limit => 50
      t.column :status, :boolean
      t.column :data_cadastro, :date
      #chaves estrangeiras
      t.column :cep_id, :integer
      t.column :parametro_id, :integer
      t.column :plano_id, :integer
    end
  end

  def self.down
    drop_table :empresas
  end
end
