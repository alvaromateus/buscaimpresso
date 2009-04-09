class CreateTipoOrcamentos < ActiveRecord::Migration
  def self.up
    create_table :tipo_orcamentos do |t|
      t.column :descricao, :string, :limit => 50
      t.column :ISS, :decimal, :precision =>10, :scale =>2
      t.column :IPI, :decimal, :precision =>10, :scale =>2
      t.column :ISV, :decimal, :precision =>10, :scale =>2
      t.column :ICMS, :decimal, :precision =>10, :scale =>2
      t.column :lado1, :integer
      t.column :lado2, :integer
      # chave estrangeira
      t.column :tipo_id, :integer
      t.column :empresa_id, :integer
    end
  end

  def self.down
    drop_table :tipo_orcamentos
  end
end
