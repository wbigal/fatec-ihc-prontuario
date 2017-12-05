module Api
  class DoctorsController < Api::BaseController
    def create
      @pessoa = Pessoa.find_by!(cns: doctor_params[:cns])

      if @pessoa.medico.blank?
        create_medico
      else
        render json: Hash[errors: 'Esta pessoa já é um médico'],
               status: :unprocessable_entity
      end
    end

    private

    def doctor_params
      params.require(:medico).permit(
        :crm,
        :cns
      )
    end

    def create_medico
      @medico = @pessoa.build_medico(crm: doctor_params[:crm])

      if @medico.save
        render json: @medico, status: :created
      else
        render json: Hash[errors: @medico.errors], status: :unprocessable_entity
      end
    end
  end
end
