# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  $('.tabs li.disabled').on 'click', 'a', (e) ->
    e.preventDefault()

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('div.count').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).parent().parent().before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $ ->
    $("#logs").scrollTop($("#log_block").prop('scrollHeight'))

  $ ->
    $("#new_permission").on 'click', '.new_permission', (event) ->
      name = $("#new_permission a").parent().find("#new_permission_name").val()
      if name != ""
        str = "<div class=\"col col-2 new_param\"><input name='prms[" + name + "]' type='hidden' value='1'><input type=\"checkbox\" value='1' checked='checked' name=\"prms[" + name + "]\" id=\"prms_" + name + "\" > - " + name + " (<a href=\"#\" class=\"del_perm\">Удалить</a>)</div>"
        $("#permissions_list").append(str)
        $("#new_permission a").parent().find("#new_permission_name").val("")
      event.preventDefault()
