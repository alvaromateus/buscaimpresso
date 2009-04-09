# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20) do

  create_table "ceps", :force => true do |t|
    t.integer "cep"
    t.string  "logradouro",      :limit => 60
    t.string  "tipo_logradouro", :limit => 20
    t.string  "bairro",          :limit => 30
    t.string  "cidade",          :limit => 30
    t.string  "uf",              :limit => 2
  end

  create_table "empresas", :force => true do |t|
    t.string  "cnpj",                :limit => 14
    t.string  "inscricao_estadual",  :limit => 50
    t.string  "inscricao_municipal", :limit => 50
    t.string  "razao_social",        :limit => 50
    t.string  "nome_fantasia",       :limit => 50
    t.string  "login",               :limit => 10
    t.string  "senha",               :limit => 8
    t.string  "complemento",         :limit => 20
    t.string  "telefone",            :limit => 15
    t.string  "fax",                 :limit => 15
    t.string  "email",               :limit => 50
    t.string  "homepage",            :limit => 50
    t.boolean "status"
    t.date    "data_cadastro"
    t.integer "cep_id"
    t.integer "parametro_id"
    t.integer "plano_id"
  end

  add_index "empresas", ["cep_id"], :name => "fk_empresa_cep"
  add_index "empresas", ["plano_id"], :name => "fk_empresa_plano"
  add_index "empresas", ["parametro_id"], :name => "fk_empresa_parametro"

  create_table "maquinas", :force => true do |t|
    t.string  "descricao",         :limit => 30
    t.integer "largura_maxima1"
    t.integer "largura_minima1"
    t.integer "largura_maxima2"
    t.integer "largura_minima2"
    t.integer "tamanho_pinca"
    t.integer "numerador"
    t.integer "quebra1000"
    t.integer "quebra5000"
    t.integer "quebra_5000"
    t.integer "reducao_chapado"
    t.integer "reducao_numerador"
    t.integer "acerto_numerador"
    t.integer "acerto"
    t.integer "quebra_chapado"
    t.decimal "custo",                           :precision => 10, :scale => 2
    t.integer "ciclo_guilhotina"
  end

  create_table "ordem_servicos", :force => true do |t|
    t.string  "descricao",         :limit => 50
    t.integer "quantidade"
    t.date    "data_entrada"
    t.decimal "valor",                           :precision => 10, :scale => 2
    t.integer "vendedor_id"
    t.integer "usuario_id"
    t.integer "tipo_orcamento_id"
  end

  add_index "ordem_servicos", ["vendedor_id"], :name => "fk_ordem_servico_vendedor"
  add_index "ordem_servicos", ["usuario_id"], :name => "fk_ordem_servico_usuario"
  add_index "ordem_servicos", ["tipo_orcamento_id"], :name => "fk_ordem_servico_tipo_orcamento"

  create_table "papels", :force => true do |t|
    t.string  "descricao",       :limit => 30
    t.integer "lado1"
    t.integer "lado2"
    t.integer "gramatura"
    t.decimal "preco_folha",                   :precision => 10, :scale => 2
    t.integer "abs_tinta"
    t.boolean "tira_retira"
    t.boolean "envelope_pronto"
    t.boolean "papel_carbono"
    t.string  "tipo",            :limit => 20
  end

  create_table "parametros", :force => true do |t|
    t.integer "refile_padrao"
    t.float   "tinta_acerto"
    t.decimal "preco_tinta_preta",                :precision => 10, :scale => 2
    t.decimal "preco_tinta_cor",                  :precision => 10, :scale => 2
    t.integer "markup"
    t.string  "observacoes",       :limit => 250
  end

  create_table "planos", :force => true do |t|
    t.string  "descricao",        :limit => 20
    t.integer "quant_transacoes"
    t.boolean "suporte"
    t.boolean "gestao_comercial"
    t.decimal "valor",                          :precision => 10, :scale => 2
    t.integer "periodo"
  end

  create_table "processo_tipo_orcamentos", :force => true do |t|
    t.integer "tipo_orcamento_id"
    t.integer "processo_id"
  end

  add_index "processo_tipo_orcamentos", ["processo_id"], :name => "fk_processo_tipo_orcamento_processo"
  add_index "processo_tipo_orcamentos", ["tipo_orcamento_id"], :name => "fk_processo_tipo_orcamento_tipo_orcamento"

  create_table "processos", :force => true do |t|
    t.string  "nome",               :limit => 20
    t.boolean "tercerizado"
    t.string  "descricao_material", :limit => 30
    t.decimal "custo",                            :precision => 10, :scale => 2
    t.integer "multiplicar"
    t.integer "quantidade_paginas"
    t.integer "produtividade"
    t.decimal "quantidade_acerto",                :precision => 10, :scale => 2
    t.string  "cor",                :limit => 10
    t.integer "maquina_id"
    t.integer "papel_id"
  end

  add_index "processos", ["papel_id"], :name => "fk_papel_processo"
  add_index "processos", ["maquina_id"], :name => "fk_maquina_processo"

  create_table "tipo_orcamentos", :force => true do |t|
    t.string  "descricao",  :limit => 50
    t.decimal "ISS",                      :precision => 10, :scale => 2
    t.decimal "IPI",                      :precision => 10, :scale => 2
    t.decimal "ISV",                      :precision => 10, :scale => 2
    t.decimal "ICMS",                     :precision => 10, :scale => 2
    t.integer "lado1"
    t.integer "lado2"
    t.integer "tipo_id"
    t.integer "empresa_id"
  end

  add_index "tipo_orcamentos", ["tipo_id"], :name => "fk_tipo_impresso"
  add_index "tipo_orcamentos", ["empresa_id"], :name => "fk_tipo_orcamentos_empresas"

  create_table "tipos", :force => true do |t|
    t.string "descricao", :limit => 30
    t.string "obs",       :limit => 150
  end

  create_table "usuarios", :force => true do |t|
    t.string  "nome",          :limit => 30
    t.string  "login",         :limit => 10
    t.string  "senha",         :limit => 8
    t.string  "fone",          :limit => 15
    t.string  "email",         :limit => 50
    t.string  "complemento",   :limit => 20
    t.date    "data_cadastro"
    t.integer "cep_id"
  end

  add_index "usuarios", ["cep_id"], :name => "idx_cep"

  create_table "vendedors", :force => true do |t|
    t.string  "nome",          :limit => 30
    t.string  "fone",          :limit => 15
    t.string  "email",         :limit => 50
    t.string  "login",         :limit => 10
    t.string  "senha",         :limit => 8
    t.integer "comissao"
    t.date    "data_cadastro"
    t.integer "empresa_id"
  end

  add_index "vendedors", ["empresa_id"], :name => "fk_vendedor_empresa"

end
