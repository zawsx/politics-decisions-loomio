@When /^I start a proposal$/, (callback) ->
  @browser.findElement(@by.css('.cuke-show-new-proposal-form-btn')).click().then =>
    @browser.findElement(@by.model('motion.title')).sendKeys('Prop 55').then =>
      @browser.findElement(@by.model('motion.description')).sendKeys('We make gravy while the sun shines').then =>
        @browser.findElement(@by.css('cuke-create-proposal-btn')).click().then =>
            callback()

@Then /^my proposal should be active$/, (callback) ->
  # express the regexp above with the code you wish you had
  callback.pending()
