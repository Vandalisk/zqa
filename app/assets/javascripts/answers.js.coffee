# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'click', '.edit-answer-link', (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit-answer-' + answer_id).show();

  questionId = $('.answers').data('questionId');
  channel = '/questions/' + questionId + '/answers'
  PrivatePub.subscribe channel, (data, channel) ->
    console.log(data)
    answer = $.parseJSON(data['answer'])
    $('.answers').append('<p class="answer">' + answer.body + '</p>')
    $('.answers').append('<p><a href="#" class="edit-answer-link" data-answer-id="' + answer.id + '">Edit</a></p>')
    $('.answers').append('<p><a class="delete-answer-link" data-confirm="Are you sure?" data-method="delete" href="/answers/'+answer.id+'">Delete</a></p>')
    form_html = '<form id="edit-answer-' + answer.id + '" class="edit_answer" action="/answers/' + answer.id + '" accept-charset="UTF-8" data-remote="true" method="post"><input name="utf8" type="hidden" value="✓"><input type="hidden" name="_method" value="patch"><label for="answer_body">Answer</label><textarea name="answer[body]" id="answer_body">' + answer.body + '</textarea><input type="submit" name="commit" value="Save"></form>';
    $('.answers').append('<p>' + form_html + '</p>')
    $('.new_answer #answer_body').val('');

    