Feature: Talk submission form
  This feature will describe the Talk submission form. 

  Scenario: Potential speaker registers his talk
    Given my name is Creil Naven
    And my talk proposal has the following information
    | Talk Title | Subject             | Category | Duration |
    | My Talk    | My talk about talks | Talks    | 45mins   |
    When I submit my talk proposal
    Then I will be in the list of possible presenters
    And my talk proposal will be on the list of proposals
    And I will see a confirmation that my proposal has been submitted

  Scenario: Potential speaker registers his workshop
    Given my name is Carlo Paroli
    And my workshop proposal has the following information
    | Talk Title  | Subject                  | Category | Duration |
    | My Workshop | My workshop about babies | Workshop | 90mins   |
    When I submit my workshop proposal
    Then I will be in the list of possible presenters
    And my workshop proposal will be on the list of proposals
    And I will see a confirmation that my proposal has been submitted

  @wip
  Scenario Outline: 
    Given my name is Neil Craven
    And my talk proposal has the following information
    | Talk Title | <title>    |
    | Subject    | <subject>  |
    | Category   | <category> |
    | Duration   | <Duration> |
    
    When I submit my talk proposal
    Then I will be told that I need to check my information for problems
    And I will be able to resubmit

    Examples:
    | Row | <title> | <subject> | <category> | <Duration> |
    |   1 |         |           |            |            |
    |   2 |         |           |            |            |
    |   3 |         |           |            |            |

