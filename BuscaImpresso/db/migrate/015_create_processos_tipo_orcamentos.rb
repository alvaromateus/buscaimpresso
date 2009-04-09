class CreateProcessosTipoOrcamentos < ActiveRecord::Migration
  def self.up
    create_table :processo_tipo_orcamentos do |t|
      t.column :tipo_orcamento_id, :integer
      t.column :processo_id, :integer
    end
  end

  def self.down
    drop_table :processo_tipo_orcamentos
  end
end
