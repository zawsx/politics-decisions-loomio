module.exports = ->
  @World = require("../../support/world.coffee").World

  @When /^I click 'Start a proposal'$/, (callback) ->
    @browser.findElement(@by.css('.cuke-show-new-proposal-form-btn')).click().then =>
      callback()

  @When /^I fill in the proposal form$/, (callback) ->
    @browser.findElement(@by.model('proposal.title')).sendKeys('Prop 55').then =>
      @browser.findElement(@by.model('proposal.description')).sendKeys('We make gravy while the sun shines').then =>
        @browser.findElement(@by.css('cuke-submit-proposal-btn')).click().then =>
            callback()

  @When /^click 'Create proposal'$/, (callback) ->
    # express the regexp above with the code you wish you had
    callback.pending()

  @Then /^my proposal should be the current proposal$/, (callback) ->
    # express the regexp above with the code you wish you had
    callback.pending()

