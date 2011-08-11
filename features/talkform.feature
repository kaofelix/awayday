Feature: Talk submission form
  This feature will describe the Talk submission form. 

  @wip
  Scenario: Potential speaker registers their interest
    Given my name is Neil Craven
    And my talk proposal has the following information
    | Talk Title | "My Talk"             |
    | Subject    | "My talk about talks" |
    | Category   | "Talks"               |
    | Duration   | "45 mins"             |
    When I submit my talk proposal
    Then my talk proposal will be on the list of talk proposals
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

