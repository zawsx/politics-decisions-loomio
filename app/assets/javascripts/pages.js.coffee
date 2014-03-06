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