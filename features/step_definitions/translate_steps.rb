require 'watir'

browser = Watir::Browser.new :firefox
test_site = 'https://translate.google.com/'


Given(/^I am on the Google Translate homepage$/) do
  browser.goto(test_site)
end

Then(/^I will translate "(.*?)"$/) do |translateText|

  browser.textarea(:id => 'source').when_present.set translateText

end

Then(/^I should see "(.*?)"$/) do |exceptedText|

  result = browser.span(:id => 'result_box').span(:class => 'hps').text
  result.should == exceptedText

end

Then(/^I will click on Login link$/) do
  browser.link(:id => 'gb_70').when_present.click
end

Then(/^I will login with login "(.*?)" and password "(.*?)"$/) do |login, password|
  browser.text_field(:id => 'Email').set login
  browser.text_field(:id => 'Passwd').set password
  #submit credentials
  browser.button(:name => 'signIn').click
end

Then(/^I should see "(.*?)" on the right top$/) do |link_text|
  result = browser.element(:text => link_text).present?
  if !result
    fail(StandardError.new('Logon unsuccessful'))
  end
end


Then(/^I will toggle automatic translation$/) do
  browser.link(:id => 'gt-otf-switch').click
end


Then(/^I will switch source language to German \("(.*?)"\)$/) do |source_language|
  elelments = browser.div(:id => 'gt-sl-sugg').divs
  found = false
  elelments.each do |element|
    if element.value == source_language
      found = true
      element.click
    end
  end
  if !found
    fail(StandardError.new(source_language + ' not found!'))
  end

end

Then(/^I will switch destination language to English\("(.*?)"\)$/) do |destination_language|
  elelments = browser.div(:id => 'gt-tl-sugg').divs
  found = false
  elelments.each do |element|
    if element.value == destination_language
      found = true
      element.click
    end
  end
  if !found
    fail(StandardError.new(destination_language + ' not found!'))
  end
end

Then(/^I will submit translation$/) do
  browser.element(:id => 'gt-submit').click
end


Then(/^I will use link hint and switch language to "(.*?)"$/) do |helper_text|
  browser.link(:text => helper_text).when_present.click
end

Then(/^I will add word to phrasebook$/) do
  browser.div(:id => 'gt-pb-star').divs[0].click
end


Then(/^I will show the phrasebook$/) do
  browser.div(:id => 'gt-pb-sw1').divs[0].click
end

Then(/^I should see "(.*?)" in phrasebook$/) do |text|
  elements = browser.divs(:class => 'gt-pb-ttc')
  found = false
  elements.each do |element|
    if element.text == text
      found = true
    end
  end
  if !found
    fail(StandardError.new(text + ' not found in phrasebook!'))
  end
end

Then(/^I will select elements of phrasebook$/) do
  browser.div(:id => 'pb-cb-a').divs[0].when_present.click
end


Then(/^I will remove elements of phrasebook$/) do
  browser.div(:id => 'pb-del-c').divs[0].when_present.click
end

And(/^I should see that any elements doesn't exist in phrasebook$/) do
  browser.divs(:class => 'gt-pb-ttc').length.should == 0
end