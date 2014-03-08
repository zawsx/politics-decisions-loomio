



$ ->
	$("body").on "click", "#mailchimp-subscribe-button", (e) ->
		$('#mailchimp-subscribe-button').hide()
		$('.mailchimp-subscribe-form').show()
	# Placeholder shim
	$.placeholder.shim();


$ ->
	$(".js-not-yet-button").on "click", (e) ->
		$(this).hide()
		$(this).parent().append(
			"<div class='coming-soon-button'>
				<div>Crowdfunding launches Tuesday, March 11th.</div>
				<div>In the mean time you can <a href=\"https://www.thunderclap.it/projects/9310-bring-loomio-to-the-world?\">Join the Thunderclap</a></div>
				<div>or <a href=\"http://loom.us5.list-manage.com/subscribe/post?u=9902f85604978f8063e266051&id=2a9fbf657e\">subscribe to our mailiing list</a></div>
				<div>Stay tuned!</div>
			</div>"
		)
		return false

$ ->
	$(".js-not-yet-row").on "click", (e) ->
		$(this).html(
			"<div class='coming-soon-row'>
				<div class='header'>Crowdfunding launches Tuesday, March 11th.</div>
				<div>In the mean time you can <a href=\"https://www.thunderclap.it/projects/9310-bring-loomio-to-the-world?\">Join the Thunderclap</a></div>
				<div>or <a href=\"http://loom.us5.list-manage.com/subscribe/post?u=9902f85604978f8063e266051&id=2a9fbf657e\">subscribe to our mailiing list</a></div>
				<div>Stay tuned!</div>
			</div>"
		)
		return false


$ ->
	$('#product-carousel').carousel('pause')
	$('#threads').on 'click', () ->
		$('#product-carousel').carousel(0)
	$('#weaving').on 'click', () ->
		$('#product-carousel').carousel(1)
	$('#braid').on 'click', () ->
		$('#product-carousel').carousel(2)

	$('.carousel-inner').on 'click', ->
		$('#product-carousel').carousel('next')
	return

$ ->
	$('#prototype-carousel').carousel('pause')


$ ->

	fadeIn = (key) ->
		element = '#' + key
		$(element).find('.step-img').removeClass('hide-background').find('.top').fadeTo(400, 0)
		$(element).find('h2').addClass('active')
		$(element).find('p').addClass('active')
		return

	fadeOut = (key) ->
		element = '#' + key
		$(element).find('h2').removeClass('active')
		$(element).find('p').removeClass('active')
		$(element).find('.top').fadeTo(300, 1, ->
			$(element).find('.step-img').addClass('hide-background')
			return
		)
		return

	$('#product-carousel').on 'slide.bs.carousel', (e) ->
		oldIndex = $(this).find('.active').index()
		newIndex = $(e.relatedTarget).index()

		switch oldIndex
			when 0 then fadeOut('threads')
			when 1 then fadeOut('weaving')
			when 2 then fadeOut('braid')

		switch newIndex
			when 0 then fadeIn('threads')
			when 1 then fadeIn('weaving')
			when 2 then fadeIn('braid')



	return 


