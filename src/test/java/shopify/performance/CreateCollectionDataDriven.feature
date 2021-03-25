Feature: Test Shopify performance

    Background: Define setup params
        Given url baseUrl

    @TestDataGenerator
    Scenario: Create unique collection using Test Data Generator
        # * def collectionName = dataGenerator.getUniqueCollectionName();
        * def collectionName = __gatling.collection_name
        * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
        # or function(ms){ } for a no-op !
        * def pause = karate.get('__gatling.pause', sleep)

        Given path 'custom_collections.json'
        And request {"custom_collection": {"title": "#(collectionName)"}}
        When method Post
        Then status 201
        Then match response.custom_collection.title == "#(collectionName)"
        # Delete the collection as a clean up task
        # Add pause between create and delete to mimic actual user behavior
        # * pause(5000)
        # * def collection_id = response.custom_collection.id + '.json'
        # Given path 'custom_collections', collection_id 
        # # Given header X-Shopify-Access-Token = accessToken
        # When method Delete
        # Then status 200
