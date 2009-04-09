class CreateOrdemServicos < ActiveRecord::Migration
  def self.up
    create_table :ordem_servicos do |t|
      t.column :descricao, :string, :limit => 50
      t.column :quantidade, :integer
      t.column :data_entrada, :date
      t.column :valor, :decimal, :precision =>10, :scale =>2
      #chaves estrangeiras
      t.column :vendedor_id, :integer
      t.column :usuario_id, :integer
      t.column :tipo_orcamento_id, :integer
    end
  end

  def self.down
    drop_table :ordem_servicos
  end
end
