Feature: Talk submission form
  This feature will describe the Talk submission form. 

  Scenario: Potential speaker registers his talk
    Given my name is Creil Naven and my email is creil.naven@awayday.com
    And my talk proposal has the following information
    | Title    | Summary                                             | Category | Duration |
    | My Talk  | My talk about talks that need a big enough summary! | SIP      | 45mins   |
    When I submit my talk proposal
    Then I will be in the list of possible presenters
    And my talk proposal will be on the list of proposals
    And I will see a confirmation that my proposal has been submitted

  Scenario: Potential speaker registers his workshop
    Given my name is Carlo Paroli and my email is carlo.paroli@awayday.com
    And my workshop proposal has the following information
    | Title       | Summary                                               | Category  | Duration |
    | My Workshop | My workshop about babies that needs to explain enough | Technical | 90mins   |
    When I submit my workshop proposal
    Then I will be in the list of possible presenters
    And my workshop proposal will be on the list of proposals
    And I will see a confirmation that my proposal has been submitted

  Scenario: Potential speaker try to register with short summary
    Given my name is Carlo Paroli and my email is carlo.paroli@awayday.com
    And my workshop proposal has the following information
    | Title       | Summary                   | Category  | Duration |
    | My Workshop | My really quick workshop  | Technical | 90mins   |
    When I submit my workshop proposal
    Then I wont be in the list of possible presenters
    And my workshop proposal wont be on the list of proposals
    And I will see a message stating that something went wrong
    And a message saying that the summary is too short

  Scenario: Potential speaker forget his name
    Given my name is  and my email is carlo.paroli@awayday.com
    And my workshop proposal has the following information
    | Title       | Summary                   | Category  | Duration |
    | My Workshop | My talk about talks that need a big enough summary! | Technical | 90mins   |
    When I submit my workshop proposal
    Then I wont be in the list of possible presenters
    And my workshop proposal wont be on the list of proposals
    And I will see a message stating that something went wrong
    And a message saying that I forgot my name

  Scenario: Potential speaker forget his name and the title of the presentation
    Given my name is  and my email is carlo.paroli@awayday.com
    And my workshop proposal has the following information
    | Title       | Summary                   | Category  | Duration |
    |             | My talk about talks that need a big enough summary! | Technical | 90mins   |
    When I submit my workshop proposal
    Then I wont be in the list of possible presenters
    And my workshop proposal wont be on the list of proposals
    And I will see a message stating that something went wrong
    And a message saying that I forgot my name
    And a message saying that I forgot the title of the talk

  Scenario Outline: A presenter can choose between some defined categories
    Given my name is John Presentation and my email is john.presentation@awayday.com
    And my talk proposal has the following information
    | Title     | Summary                                                    | Category   | Duration   |
    | The Title | The Summary for the example need to have at least 50 chars | <category> | 45mins     |
    When I submit my talk proposal
    Then I will be in the list of possible presenters
    And my talk proposal will be on the list of proposals
    And I will see a confirmation that my proposal has been submitted

    Examples:
    | category                      |
    | SIP                           |
    | Technical                     |
    | Non-Technical                 |
    | Entrepreuneurial              |
    | Life Skills                   |
    | Nothing to do with Technology |
    | Health and Well Being         |
    | Hobbies                       |

    #When I submit my talk proposal
    #Then I will be told that I need to check my information for problems
    #And I will be able to resubmit
