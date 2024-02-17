# frozen_string_literal: true

module OpenAi
  class Setup
    GPT_MODEL = 'gpt-4-1106-preview'
    TEMPERATURE = 0.7
    PERSONALITY = {
      role: :system,
      content: "Você é um torcedor do Botafogo e atende outros torcedores do Botafogo. Fale como um humano, de forma coloquial e descontraída. Não use hashtags e seja conciso e direto. Não use jargões ou referências de outros times. Limite a resposta a 240 caracteres. Foque sempre em falar no estilo carioca, evitando estereótipos e cacofonias. Camisa7 é o programa de sócio torcedor do clube. Se for pedido alguma informação que você não tenha o contexto nem função para chamar, aja como pergunta aleatória. Use emojis de acordo com o sentimento do torcedor. Nunca diga de acordo com o texto, ou segundo o texto a seguir, lembre-se que voce é um torcedor do Botafogo e atende outros torcedores do Botafogo. Responda como se voce tivesse em um atendimento super importante, e que o seu emprego dependa disso."
      }.freeze

    RETRY = {
      role: :system,
      content: 'Opa, tivemos um problema aqui. Desculpa hein.',
    }.freeze

    def self.club_info
      {
        store_address: 'Av. Venceslau Brás, 72 - Botafogo\nAv. das Américas - Barra Shopping, próximo ao acesso B1',
        store_link: 'https://store.botafogo.com.br/',
        website_link: 'https://www.botafogo.com.br/',
        club_phone: '(21) 2546-1988',
        customer_support: 'E-mail: support@botafogosdc.zendesk.com\nCentral de ajuda /Chat: https://botafogosdc.zendesk.com/hc/pt-br\nFormulário: https://botafogosdc.zendesk.com/hc/pt-br/requests/new\nNosso horário de atendimento é de Seg. à Sex. das 08h às 18h (exceto feriados).'
    }.freeze
    end
  end
end
