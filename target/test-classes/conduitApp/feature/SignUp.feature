
Feature: Sign Up new user

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
    Given url apiUrl


Scenario: New user Sign Up
    Given path 'users'
    And request 
    """
        {
        "user": {
        "email":#(randomEmail),
        "password": "test",
        "username":#(randomUsername)
    }
}
    """
    When method Post 
    Then status 200
    And match response ==
    """
        {
            "user": {
                "email": "#(randomEmail)",
                "username": "#(randomUsername)",
                "bio": null,
                "image": "#string",
                "token": "#string"
            }
        }
    """


Scenario Outline: Validate Sign Up error messages
    Given path 'users'
    And request 
    """
        {
        "user": {
        "email":"<email>",
        "password": "<password>",
        "username":"<username>"
    }
}
    """
    When method Post 
    Then status 422
    And match response == <errorResponse>

    Examples:
        | email              | password | username           | errorResponse                                      |
        | #(randomEmail)     | test     | paolla1            | {"errors":{"username":["has already been taken"]}} |
        | testing3@test.com  | test     | #(randomUsername)  | {"errors":{"email":["has already been taken"]}}    |
    