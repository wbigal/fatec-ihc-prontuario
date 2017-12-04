module Patients
  class MyMedicalRecordsController < ApplicationController
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
      query = Atendimento.joins(:pessoa, medico: :pessoa).where(
        pessoa: current_pessoa
      )
      query = query_doctor_name(query)
      query = query_dates(query)
      query.order(data_atendimento: :desc)
    end

    def query_dates(query)
      query.where(
        data_atendimento: @search.initial_date...@search.final_date
      )
    end

    def query_doctor_name(query)
      return query if @search.doctor_name.blank?
      query.where(
        'lower(pessoas_medicos.nome_completo) LIKE ?',
        "%#{@search.doctor_name.downcase}%"
      )
    end
  end
end
