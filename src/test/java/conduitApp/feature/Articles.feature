@debug
Feature: Articles

    Background: Define URL
        # Given url apiUrl
        * url apiUrl
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
        * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
        * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body


    Scenario: Create a new Article
        Given path 'articles'
        # And request {"article": {"title": "test 12334 bla2123","description": "test","body": "test","tagList": []}}
        And request articleRequestBody
        When method Post 
        Then status 201
        And match response.article.title == articleRequestBody.article.title

    Scenario: Create and Delete Articles
        Given path 'articles'
        # And request {"article": {"title": "Delete Article","description": "test","body": "test","tagList": []}}
        And request articleRequestBody
        When method Post 
        Then status 201
        * def articleId = response.article.slug

        Given params {limit : 10, offset : 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == articleRequestBody.article.title

        Given path 'articles',articleId
        When method Delete
        Then status 204

        Given params {limit : 10, offset : 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestBody.article.title



