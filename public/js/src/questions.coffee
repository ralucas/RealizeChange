$ ->
	$('#questionPrompt').on 'click', (e) ->
		e.preventDefault()
		val = $(this).serialize()
		$.get('/sendquestion', val, (data) ->
			console.log(data)