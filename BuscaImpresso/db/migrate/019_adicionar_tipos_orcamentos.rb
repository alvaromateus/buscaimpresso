class AdicionarTiposOrcamentos < ActiveRecord::Migration
  def self.up
    Tipo.create(:descricao =>'NOTA FISCAL', :obs =>'Blocos de notas fiscais numerados')
    Tipo.create(:descricao =>'TALÕES')
    Tipo.create(:descricao =>'BLOCOS')
    Tipo.create(:descricao =>'REVISTAS')
    Tipo.create(:descricao =>'FOLDERS')
    Tipo.create(:descricao =>'MALA DIRETA')
    Tipo.create(:descricao =>'ENVELOPE')
    Tipo.create(:descricao =>'PANFLETO')
    Tipo.create(:descricao =>'CARTÃO DE VISITA', :obs =>'Cartão de visita 7x5')
    Tipo.create(:descricao =>'CARTAZ')
    Tipo.create(:descricao =>'LIVRO')
    Tipo.create(:descricao =>'JORNAL')
  end

  def self.down
  end
end
