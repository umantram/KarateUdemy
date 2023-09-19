Feature: Sign Up User   

Background: Precondition
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomusername = dataGenerator.getRandomUsername()
    Given url apiUrl

Scenario: new User
    # Given def userData = {"email": "karate4@karate.com", "username": "Karate4"}

    Given path 'users'
    And request 
    """
        {"user": 
            {"email": #(randomEmail),
            "password": "karate45678",
            "username": #(randomusername)
            }
        }
    """
    When method Post
    Then status 201
    And match response == 
    """
        {
            "user": {
                "email": #(randomEmail),
                "username": #(randomusername),
                "bio": null,
                "image": "#string",
                "token": "#string"
            }
        }
    """

Scenario Outline: Validate Sing up error message

    Given path 'users'
    And request 
    """
        {"user": 
            {"email": "<email>",
            "password": "<password>",
            "username": "<username>"
            }
        }
    """
    When method Post
    Then status 422
    And match response == <errorResponse>

    Examples:
        | email                  | password  | username          | errorResponse  |
        | #(randomEmail)         | karate123 | Karate4567        | {"errors":{"username":["has already been taken"]}}
        | karate4567@karate.com  | karate123 | #(randomusername) | {"errors":{"email":["has already been taken"]}}





# Scenario: Validate Sing up error message username
#     * def randomEmail = dataGenerator.getRandomEmail()
#     * def randomusername = dataGenerator.getRandomUsername()

#     Given path 'users'
#     And request 
#     """
#         {"user": 
#             {"email": #(randomEmail),
#             "password": "karate45678",
#             "username": "Karate4567"
#             }
#         }
#     """
#     When method Post
#     Then status 422