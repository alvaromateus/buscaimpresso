class CreateMaquinas < ActiveRecord::Migration
  def self.up
    create_table :maquinas do |t|
      t.column :descricao, :string, :limit => 30
      t.column :largura_maxima1, :integer
      t.column :largura_minima1, :integer
      t.column :largura_maxima2, :integer
      t.column :largura_minima2, :integer
      t.column :tamanho_pinca, :integer
      t.column :numerador, :integer
      t.column :quebra1000, :integer
      t.column :quebra5000, :integer
      t.column :quebra_5000, :integer
      t.column :reducao_chapado, :integer
      t.column :reducao_numerador, :integer
      t.column :acerto_numerador, :integer
      t.column :acerto, :integer
      t.column :quebra_chapado, :integer
      t.column :custo, :decimal, :precision =>10, :scale =>2
      t.column :ciclo_guilhotina, :integer
    end
  end

  def self.down
    drop_table :maquinas
  end
end
