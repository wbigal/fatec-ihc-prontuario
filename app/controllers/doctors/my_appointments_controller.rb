module Doctors
  class MyAppointmentsController < Doctors::BaseController
    def index
      @search = Doctors::MyAppointments::SearchForm.new
    end

    def search_result
      @search = Doctors::MyAppointments::SearchForm.new(search_params)

      if @search.valid?
        @atendimentos = search_atendimentos
      else
        render :index unless @search.valid?
      end
    end

    def show
      @atendimento = Atendimento.joins(:pessoa).find_by!(
        id: params[:id],
        medico: current_pessoa.medico
      )
    end

    private

    def search_params
      params.require(:doctors_my_appointments_search_form).permit(
        :initial_date,
        :final_date,
        :patient_name,
        :query_text
      )
    end

    def search_atendimentos
      Atendimento.search(
        initial_date: @search.initial_date,
        final_date: @search.final_date,
        params: query_params
      ).records.joins(:pessoa)
    end

    def query_params
      query_params = Hash[medico_id: current_pessoa.medico.id]

      if @search.query_text.present?
        query_params[:query_text] = @search.query_text
      end

      if @search.patient_name.present?
        query_params[:pessoa_nome] = @search.patient_name
      end

      query_params
    end
  end
end
