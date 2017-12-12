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
        :patient_name
      )
    end

    def search_atendimentos
      params = Hash[medico_id: current_pessoa.medico.id]
      if @search.patient_name.present?
        params[:pessoa_nome] = @search.patient_name
      end
      Atendimento.search(
        initial_date: @search.initial_date,
        final_date: @search.final_date,
        params: params
      ).records.joins(:pessoa)
    end
  end
end
