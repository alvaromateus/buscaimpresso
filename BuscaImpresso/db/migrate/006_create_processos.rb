class CreateProcessos < ActiveRecord::Migration
  def self.up
    create_table :processos do |t|
      t.column :nome, :string, :limit => 20
      t.column :tercerizado, :boolean
      t.column :descricao_material, :string, :limit => 30
      t.column :custo, :decimal, :precision =>10, :scale =>2
      t.column :multiplicar, :integer
      t.column :quantidade_paginas, :integer
      t.column :produtividade, :integer
      t.column :quantidade_acerto, :decimal, :precision =>10, :scale =>2
      t.column :cor, :string, :limit => 10
      #chaves estrangeiras
      t.column :maquina_id, :integer
      t.column :papel_id, :integer
    end
  end

  def self.down
    drop_table :processos
  end
end
