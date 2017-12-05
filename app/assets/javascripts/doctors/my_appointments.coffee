# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require plugins/jquery.datetimepicker

$('#doctors_my_appointments_search_form_initial_date').datetimepicker(
  format:'d/m/Y H:m'
)
$('#doctors_my_appointments_search_form_final_date').datetimepicker(
  format:'d/m/Y H:m'
)
$.datetimepicker.setLocale 'pt-BR'
