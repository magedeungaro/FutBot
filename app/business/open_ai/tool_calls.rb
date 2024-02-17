# frozen_string_literal: true

module OpenAi
  class ToolCalls
    def self.functions
      [
        {
          name: :handle_swearing,
          description: 'Use essa função para responder torcedores muito bravos e que estão xingando o time e mostrando insatisfação de forma agressiva.'
        },
        {
          name: :handle_sign_up,
          description: 'Use essa função para responder torcedores que estão buscando se tornar sócio torcedor e assinar o camisa7.'
        },
        {
          name: :handle_cancelling,
          description: 'Use essa função para entender melhor como lidar com o torcedor que quer cancelar o programa sócio torcedor.'
        },
        {
          name: :handle_randomness,
          description: 'Use essa função para lidar com o torcedor que sair do contexto do clube e citar sobre outros times.'
        },
        {
          name: :get_club_info,
          description: 'Use essa função para saber sobre o clube, como link oficial e telefone do clube; link, endereço físico e suporte da loja. Não inclui suporte nem link do camisa7.',
          parameters: {
            type: :object,
            properties: {
              info_kind: {
                type: :string,
                description: "Retorne o parâmetro que representa o tipo da busca. Os parâmetros possíveis são: club_phone, store_link, website_link, store_customer_support, e store_address"
              }
            },
            required: %w[info_kind]
          }
        }
      ]
    end

    def self.handle_swearing
      { 
        role: :system,
        content: 'Cara, respeita o Fogão! Vamo ficar calmo, beleza?',
        name: 'handle_swearing'
      }
    end

    def self.handle_sign_up
      {
        role: :function,
        content: 'Cara, entre no link https://camisa7.botafogo.com.br/',
        name: 'handle_sign_up'
      }
    end

    def self.handle_randomness
      {
        role: :function,
        content: 'Cara, desculpa tá? Mas só consigo auxiliar sobre o Fogão e o Camisa 7.',
        name: 'handle_randomness'
      }
    end

    def self.get_club_info(info_kind:)
      {
        role: :function,
        content: Setup.club_info[info_kind.to_sym],
        name: 'get_club_info'
      }
    end

    def self.handle_cancelling
      mood = PlaceHolderSetting.find_by(name: "social_media_mood").value
      {
        role: :function,
        content: "(Site,https://camisa7.botafogo.com.br/),(Mood redes sociais, #{mood})",
        name: 'handle_cancelling'
      }
    end
  end
end
