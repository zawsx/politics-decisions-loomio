



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

	fadeSteps = (fadeIn, fadeOuts, duration) ->
		duration = if duration? then duration else 400
		element = '#' + fadeIn
		$(element).find('.step-img').removeClass('hide-background').find('.top').fadeTo(duration, 0)
		$(element).find('h2').addClass('active')
		$(element).find('p').addClass('active')

		$.each fadeOuts, (i, fadeOut) ->
			fadeOut = '#' + fadeOut
			$(fadeOut).find('h2').removeClass('active')
			$(fadeOut).find('p').removeClass('active')
			$(fadeOut).find('.top').fadeTo(duration-100, 1, ->
				$(fadeOut).find('.step-img').addClass('hide-background')
				return
			)
			return
		return
			
	fadeSteps('threads', [], 0)

	$('#product-carousel').on 'slide.bs.carousel', (e) ->
		currentIndex = $(e.relatedTarget).index()

		switch currentIndex
			when 0 then fadeSteps('threads', ['weaving', 'braid'])
			when 1 then fadeSteps('weaving', ['threads', 'braid'])
			when 2 then fadeSteps('braid', ['threads', 'weaving'])
	return 


