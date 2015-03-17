Feature: Google Translate


  Scenario: Simple Translate
    Given I am on the Google Translate homepage
    Then I will translate "dog"
    Then I should see "собака"

  Scenario: Login Google Services
    Given I am on the Google Translate homepage
    Then I will click on Login link
    Then I will login with login "c4cumb3r@gmail.com" and password "c4c4mb3rr"
    Then I should see "c4cumb3r@gmail.com" on the right top

  Scenario: Custom Translation
    Given I am on the Google Translate homepage
    Then I will toggle automatic translation
    Then  I will translate "Krankenhaus"
    Then I will switch source language to German ("de")
    Then I will switch destination language to English("en")
    Then I will submit translation
    Then I should see "hospital"

  Scenario: Using Hints and Phrasebook
    Given I am on the Google Translate homepage
    Then I will toggle automatic translation
    Then I will translate "кошка"
    Then I will use link hint and switch language to "русский"
    Then I should see "cat"
    Then I will add word to phrasebook
    Then I will show the phrasebook
    Then I should see "cat" in phrasebook





