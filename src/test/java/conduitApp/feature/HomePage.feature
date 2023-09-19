Feature: Test for the home page

Background: Define URL
    Given url apiUrl

    Scenario: Get all tags
        #Given url 'https://api.realworld.io/api/'
        Given path 'tags'
        When method Get
        Then status 200
        # And match response.tags contains 'welcome', 'implementations'
        # And match response.tags !contains 'truck'
        # And match response.tags contains any ['fish', 'dog', 'implementations']
        And match response.tags == "#array"
        And match each response.tags == "#string"

    Scenario: Get 10 articles from the page
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        # Given param limit = 10
        # Given param offset = 0
        Given params {limit : 10, offset : 0}
        #Given url 'https://api.realworld.io/api/'
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == "#[10]"
        # And match response.articlesCount == 205
        # And match response.articlesCount != 20
        And match response == {"articles": "#array", "articlesCount": 205}
        # And match response.articles[0].createdAt contains '2023'
        # And match response.articles[*].favoritesCount contains 0
        # And match response.articles[*].author.bio contains null
        # And match each response.articles[*].following contains true
        # And match each response.articles[*].author.following == false
        # And match each response.articles[*].author.following == '#boolean'
        # And match each response.articles[*].favoritesCount == '#number'
        # And match each response.articles[*].author.bio == '##String'
        And match each response.articles ==
        """
            {
                "slug": "#string",
                "title": "#string",
                "description": "#string",
                "body": "#string",
                "tagList": "#array",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "favorited": '#boolean',
                "favoritesCount": '#number',
                "author": {
                    "username": "#string",
                    "bio": "##String",
                    "image": "#string",
                    "following": false
                }
            },
        """






