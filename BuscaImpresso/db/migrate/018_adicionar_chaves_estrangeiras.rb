class AdicionarChavesEstrangeiras < ActiveRecord::Migration
  def self.up
    #usuario
    execute "create index idx_cep on usuarios (cep_id)"
    execute "alter table usuarios add constraint fk_usuario_cep foreign key (cep_id) references ceps (id) on update cascade"

    #vendedor
    execute "alter table vendedors add constraint fk_vendedor_empresa foreign key (empresa_id) references empresas (id) on delete cascade on update cascade"

    #ordem de serviço
    execute "alter table ordem_servicos add constraint fk_ordem_servico_vendedor foreign key (vendedor_id) references vendedors (id) on delete cascade on update cascade"
    execute "alter table ordem_servicos add constraint fk_ordem_servico_usuario foreign key (usuario_id) references usuarios (id) on delete cascade on update cascade"
    execute "alter table ordem_servicos add constraint fk_ordem_servico_tipo_orcamento foreign key (tipo_orcamento_id) references tipo_orcamentos (id) on update cascade"

    #empresa
    execute "alter table empresas add constraint fk_empresa_cep foreign key (cep_id) references ceps (id) on update cascade"
    execute "alter table empresas add constraint fk_empresa_plano foreign key (plano_id) references planos (id) on update cascade"
    execute "alter table empresas add constraint fk_empresa_parametro foreign key (parametro_id) references parametros (id) on update cascade on delete cascade"

    # processos
    execute "alter table processos add constraint fk_papel_processo foreign key (papel_id) references papels (id) on update cascade on delete cascade"
    execute "alter table processos add constraint fk_maquina_processo foreign key (maquina_id) references maquinas (id) on update cascade on delete cascade"

    execute "alter table tipo_orcamentos add constraint fk_tipo_impresso foreign key (tipo_id) references tipos (id) on update cascade"

    #processo_tipo_orçamento
    execute "alter table processo_tipo_orcamentos add constraint fk_processo_tipo_orcamento_processo foreign key (processo_id) references processos (id) on update cascade"
    execute "alter table processo_tipo_orcamentos add constraint fk_processo_tipo_orcamento_tipo_orcamento foreign key (tipo_orcamento_id) references tipo_orcamentos (id) on update cascade"

    #tipo_orcamentos
    execute "alter table tipo_orcamentos add constraint fk_tipo_orcamentos_empresas foreign key (empresa_id) references empresas (id) on update cascade"
  end

  def self.down
    execute "alter table usuarios drop foreign key fk_usuario_cep"
    execute "alter table vendedors drop foreign key fk_vendedor_empresa"
    execute "alter table ordem_servicos drop foreign key fk_ordem_servico_vendedor"
    execute "alter table ordem_servicos drop foreign key fk_ordem_servico_usuario"
    execute "alter table ordem_servicos drop foreign key fk_ordem_servico_tipo_orcamento"
    execute "alter table empresas drop foreign key fk_empresa_cep"
    execute "alter table empresas drop foreign key fk_empresa_plano"
    execute "alter table empresas drop foreign key fk_empresa_parametro"
    execute "alter table papels_processos drop foreign key fk_papel_processo_papel"
    execute "alter table papels_processos drop foreign key fk_papel_processo_processo"
    execute "alter table empresas_tipo_orcamentos drop foreign key fk_empresa_tipo_orcamento_empresa"
    execute "alter table empresas_tipo_orcamentos drop foreign key fk_empresa_tipo_orcamento_tipo_orcamento"
    execute "alter table maquinas_processos drop foreign key fk_maquina_processo_maquina"
    execute "alter table maquinas_processos drop foreign key fk_maquina_processo_processo"
    execute "alter table processos_tipo_orcamentos drop foreign key fk_processo_tipo_orcamento_processo"
    execute "alter table processos_tipo_orcamentos drop foreign key fk_processo_tipo_orcamento_tipo_orcamento"
  end
end
