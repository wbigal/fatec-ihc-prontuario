require 'elasticsearch/model'

module Searchables
  module Atendimento
    extend ActiveSupport::Concern

    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks

      settings index: { number_of_shards: 1 } do
        mappings dynamic: false do
          indexes :sintomas, analyzer: :portuguese
          indexes :diagnosticos, analyzer: :portuguese
          indexes :prescricao_medicamentos, analyzer: :portuguese
          indexes :prescricao_procedimentos, analyzer: :portuguese
          indexes :data_atendimento, type: 'date'
          indexes :pessoa_id, type: 'integer'
          indexes :medico_id, type: 'integer'
          indexes :medico_nome
          indexes :pessoa_nome
        end
      end

      class << self
        def search(initial_date:, final_date:, params: {})
          query = query_init
          filter = filter_init(query)

          filter << data_atendimento_query(initial_date: initial_date,
                                           final_date: final_date)

          params.each { |key, value| filter << build_query(key, value) }

          __elasticsearch__.search(query)
        end

        private

        def query_init
          Hash[query: Hash[bool: Hash[]], sort: sort_init]
        end

        def filter_init(query)
          query[:query][:bool][:filter] = []
          query[:query][:bool][:filter]
        end

        def sort_init
          [Hash[data_atendimento: Hash[order: :desc]]]
        end

        def data_atendimento_query(initial_date:, final_date:)
          Hash[
            range: Hash[
              data_atendimento: { gte: initial_date, lte: final_date }
            ]
          ]
        end

        def build_query(key, value)
          if key == :query_text
            prontuario_query(value)
          else
            single_query(key, value)
          end
        end

        def single_query(key, value)
          Hash[match: Hash[key => value]]
        end

        def prontuario_query(query_text)
          Hash[
            multi_match: Hash[
              query: query_text,
              fields: %w[sintomas diagnosticos prescricao_medicamentos
                         prescricao_procedimentos]
            ]
          ]
        end
      end

      def as_indexed_json(_ = {})
        as_json(methods: %i[sintomas diagnosticos prescricao_medicamentos
                            prescricao_procedimentos data_atendimento
                            medico_nome pessoa_nome pessoa_id medico_id])
      end

      private

      def medico_nome
        medico&.pessoa&.nome_completo
      end

      def pessoa_nome
        pessoa&.nome_completo
      end
    end
  end
end
