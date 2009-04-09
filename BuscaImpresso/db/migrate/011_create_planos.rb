class CreatePlanos < ActiveRecord::Migration
  def self.up
    create_table :planos do |t|
      t.column :descricao, :string, :limit => 20
      t.column :quant_transacoes, :integer
      t.column :suporte, :boolean
      t.column :gestao_comercial, :boolean
      t.column :valor, :decimal, :precision =>10, :scale =>2
      t.column :periodo, :integer
    end
  end

  def self.down
    drop_table :planos
  end
end
