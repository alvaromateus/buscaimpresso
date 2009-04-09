class CreatePapels < ActiveRecord::Migration
  def self.up
    create_table :papels do |t|
      t.column :descricao, :string, :limit => 30
      t.column :lado1, :integer
      t.column :lado2, :integer
      t.column :gramatura, :integer
      t.column :preco_folha, :decimal, :precision =>10, :scale =>2
      t.column :abs_tinta, :integer
      t.column :tira_retira, :boolean
      t.column :envelope_pronto, :boolean
      t.column :papel_carbono, :boolean
      t.column :tipo, :string, :limit => 20
    end
  end

  def self.down
    drop_table :papels
  end
end
