Feature: Talk submission form
  This feature will describe the Talk submission form. 

  Scenario: Potential speaker registers his talk
    Given my name is Creil Naven
    And my talk proposal has the following information
    | Title    | Summary             | Category | Duration |
    | My Talk  | My talk about talks | SIP      | 45mins   |
    When I submit my talk proposal
    Then I will be in the list of possible presenters
    And my talk proposal will be on the list of proposals
    And I will see a confirmation that my proposal has been submitted

  Scenario: Potential speaker registers his workshop
    Given my name is Carlo Paroli
    And my workshop proposal has the following information
    | Title       | Summary                  | Category  | Duration |
    | My Workshop | My workshop about babies | Technical | 90mins   |
    When I submit my workshop proposal
    Then I will be in the list of possible presenters
    And my workshop proposal will be on the list of proposals
    And I will see a confirmation that my proposal has been submitted

  Scenario Outline: A presenter can choose between some defined categories
    Given my name is John Presentation
    And my talk proposal has the following information
    | Title     | Summary     | Category   | Duration   |
    | The Title | The Summary | <category> | 45mins     |
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
