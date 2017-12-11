module Patients
  class MyMedicalRecordsController < AuthenticatedController
    def index
      @search = Patients::MyMedicalRecords::SearchForm.new
    end

    def search_result
      @search = Patients::MyMedicalRecords::SearchForm.new(search_params)

      if @search.valid?
        @atendimentos = search_atendimentos
      else
        render :index unless @search.valid?
      end
    end

    def show
      @atendimento = Atendimento.joins(:pessoa, medico: :pessoa).find_by!(
        id: params[:id],
        pessoa: current_pessoa
      )
    end

    private

    def search_params
      params.require(:patients_my_medical_records_search_form).permit(
        :initial_date,
        :final_date,
        :doctor_name
      )
    end

    def search_atendimentos
      params = Hash[pessoa_id: current_pessoa.id]
      params[:medico_nome] = @search.doctor_name if @search.doctor_name.present?
      Atendimento.search(
        initial_date: @search.initial_date,
        final_date: @search.final_date,
        params: params
      ).records.joins(:pessoa, medico: :pessoa)
    end
  end
end
