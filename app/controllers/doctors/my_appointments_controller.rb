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
      query = Atendimento.joins(:pessoa).where(medico: current_pessoa.medico)
      query = query_patient_name(query)
      query = query_dates(query)
      query.order(data_atendimento: :desc)
    end

    def query_dates(query)
      query.where(
        data_atendimento: @search.initial_date..@search.final_date
      )
    end

    def query_patient_name(query)
      return query if @search.patient_name.blank?
      query.where(
        'lower(pessoas.nome_completo) LIKE ?',
        "%#{@search.patient_name.downcase}%"
      )
    end
  end
end
