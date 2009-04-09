class CreateParametros < ActiveRecord::Migration
  def self.up
    create_table :parametros do |t|
      t.column :refile_padrao, :integer
      t.column :tinta_acerto, :float
      t.column :preco_tinta_preta, :decimal, :precision =>10, :scale =>2
      t.column :preco_tinta_cor, :decimal, :precision =>10, :scale =>2
      t.column :markup, :integer
      t.column :observacoes, :string, :limit => 250
    end
  end

  def self.down
    drop_table :parametros
  end
end
