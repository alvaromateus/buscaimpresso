class NotificacaoVendedor < ActionMailer::Base
  def notifica_vendedor (orcamento, quantidade, email_vendedor, sent_at = Time.now)
    @subject = "Ordem de Serviço"
    @recipients = email_vendedor    
    @sent_on = sent_at                    # Data do email    
    @body['quantidade'] = quantidade 
    @body['orcamento'] = orcamento
  end
end