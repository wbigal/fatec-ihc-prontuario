module Api
  class PeopleController < Api::BaseController
    def create
      @pessoa = Pessoa.new(people_params)

      if @pessoa.save
        render json: @pessoa.to_json(except: :senha), status: :created
      else
        render json: Hash[errors: @pessoa.errors], status: :unprocessable_entity
      end
    end

    def people_params
      params.require(:pessoa).permit(
        :cns,
        :nome_completo,
        :data_nascimento
      )
    end
  end
end
