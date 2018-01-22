// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require_tree .

jQuery.datetimepicker.setLocale('ru');

jQuery('.datetimepicker').datetimepicker({
  format:'d.m.Y H:i',
  lang:'ru'
});

$(function() {
  $(document).on('change', '.new_param input:checkbox', function(e) {
    $(this).parent().find("input[type=hidden]").prop('value', (1-$(this).prop('value')));
  });
  $(document).on('click', '.del_perm', function(e) {
    $(this).parent().remove();
  });
  $('#site_srch').keyup(function(e){
    $.get('../get_sites?site_srch=' + $(this).val(), function(data){
      //alert( $(data).find("#sites_aviable").html() );
      $("#sites_aviable").html($(data).find("#sites_aviable").html());
    });
    e.preventDefault();
  });
  $('#tt select').change(function(e){
    $.get('../get_deadline?tt=' + $(this).val(), function(data){
      $(document).find("#deadline_field div").html($(data).find("#get_deadline").html())
    });
  })
});
