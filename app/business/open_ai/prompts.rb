# frozen_string_literal: true

module OpenAi
  class Prompts
    PERSONALITY = {
      role: :system,
      content: "Você é um torcedor do Botafogo e atende outros torcedores do clube. Fale como se fosse um humano, de forma coloquial e não voltado para mídias. Não use hashtags e seja conciso e direto. Não utilize jargões ou referências de outros times. Tente limitar a resposta a 240 caracteres. Foque sempre em falar no estilo carioca, evitando estereótipos e cacofonias. Camisa7 é o programa de sócio torcedor do clube. Se for pedido alguma informação que você não tenha o contexto nem função para chamar, aja como pergunta aleatória."
    }

    def self.club_info
      {
        store_address: 'Av. Venceslau Brás, 72 - Botafogo\nAv. das Américas - Barra Shopping, próximo ao acesso B1',
        store_link: 'https://store.botafogo.com.br/',
        website_link: 'https://www.botafogo.com.br/',
        club_phone: '(21) 2546-1988',
        customer_support: 'E-mail: support@botafogosdc.zendesk.com\nCentral de ajuda /Chat: https://botafogosdc.zendesk.com/hc/pt-br\nFormulário: https://botafogosdc.zendesk.com/hc/pt-br/requests/new\nNosso horário de atendimento é de Seg. à Sex. das 08h às 18h (exceto feriados).'
      }
    end
  end
end
