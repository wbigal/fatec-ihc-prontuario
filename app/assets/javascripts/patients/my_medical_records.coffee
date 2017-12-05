#= require plugins/jquery.datetimepicker

$('#patients_my_medical_records_search_form_initial_date').datetimepicker(
  format:'d/m/Y H:m'
)
$('#patients_my_medical_records_search_form_final_date').datetimepicker(
  format:'d/m/Y H:m'
)
$.datetimepicker.setLocale 'pt-BR'
