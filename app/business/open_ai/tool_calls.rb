module OpenAi
  class ToolCalls
    def self.functions
      [
        {
          name: :handle_swearing,
          description: 'Use essa função para responder torcedores muito bravos e que estão xingando o time e mostrando insatisfação'
        },
        {
          name: :handle_sign_up,
          description: 'Use essa função para responder torcedores que estão buscando se tornarem sócio torcedor'
        },
        {
          name: :get_social_media_mood_prompt,
          description: 'Use essa função para entender melhor como lidar com o torcedor que quer cancelar o programa sócio torcedor.'
        },
        {
          name: :handle_randomness,
          description: 'Use essa função para lidar com o torcedor que sair do contexto do clube.'
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
        role: :system,
        content: 'Cara, entre no link https://www.botafogo.com.br/inscricoes/',
        name: 'handle_sign_up'
      }
    end

    def self.get_social_media_mood_prompt
      social_media_mood = PlaceHolderSetting.find_by(name: "social_media_mood").value
      {
        role: :system,
        content: "Mood das redes sociais sobre o clube: #{social_media_mood}",
        name: 'social_media_mood'
      }
    end

    def self.handle_randomness
      {
        role: :system,
        content: 'Cara, desculpa tá? Mas só consigo auxiliar sobre o Fogão e o Camisa 7.'
      }
    end
  end
end
