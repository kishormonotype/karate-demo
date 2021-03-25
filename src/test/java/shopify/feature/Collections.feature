@Collections
Feature: Test Shopify Collections

    Background: Define setup params
        # * def setup = callonce read('classpath:helpers/Setup.feature')
        * def dataGenerator = Java.type('helpers.FakeDataGenerator')
        Given url baseUrl

    Scenario: Validate total count of collections in Shopify
        Given path 'custom_collections.json'
        When method Get
        Then status 200
        Then match response.custom_collections == '#[7]'
        Then match each response.custom_collections == '#object'
        And match response == {"custom_collections": "#array"}

    Scenario: Validate given product exists in a collection
        # Parameterize the collection id
        Given path 'collections/261236719822/products.json'
        When method Get
        Then status 200
        And match response.products[*].title contains "Goordy Bold"

    Scenario: Create new collection and validate title
        Given path 'custom_collections.json'
        And request {"custom_collection": {"title": "Macbooks"}}
        When method Post
        Then status 201
        Then match response.custom_collection.title == "Macbooks"
        # Delete the collection as a clean up task
        * def collection_id = response.custom_collection.id
        Given path 'custom_collections/' + collection_id + '.json'
        # Given header X-Shopify-Access-Token = accessToken
        When method Delete
        Then status 200

    @SchemaValidation @ignore
    Scenario: Schema validation for products
        *   def timeValidator = read('classpath:helpers/timeValidator.js')
        *   def expectedSchema = read('classpath:shopify/json/schemas/productSchema.json')
        
        Given path 'collections/261236719822/products.json'
        When method Get
        Then status 200
        # And match each response.products == expectedSchema
        And match each response.products == 
        """
            {
                "id": "#number",
                "title": "#string",
                "body_html": "#string",
                "vendor": "#string",
                "product_type": "#string",
                "created_at": "#? timeValidator(_)",
                "handle": "#string",
                "updated_at": "#? timeValidator(_)",
                "published_at": "#? timeValidator(_)",
                "template_suffix": "#string",
                "published_scope": "#string",
                "tags": "#string",
                "admin_graphql_api_id": "#string",
                "options": "#array",
                "images": "#array",
                "image": "##object"
            }
        """

    @TestDataGenerator
    Scenario: Create unique collection using Test Data Generator
        * def collectionName = dataGenerator.getUniqueCollectionName();

        Given path 'custom_collections.json'
        And request {"custom_collection": {"title": "#(collectionName)"}}
        When method Post
        Then status 201
        Then match response.custom_collection.title == "#(collectionName)"
        # Delete the collection as a clean up task
        * def collection_id = response.custom_collection.id
        Given path 'custom_collections/' + collection_id + '.json'
        # Given header X-Shopify-Access-Token = accessToken
        When method Delete
        Then status 200

    @DataDrivenTest
    Scenario Outline: Validate count of products in collections
        Given path 'collections/' + <collection_id> + '/products.json'
        When method Get
        Then status 200
        And match response.products == "#[<expected_products_count>]"
        Examples:
        | collection_id | expected_products_count |
        | 261236719822  | 2                       |
        | 261177409742  | 1                       |

    @DemoConditonalLogic
    Scenario Outline: Print collection with zero number of products
        Given path 'collections/' + <collection_id> + '/products.json'
        When method Get
        Then status 200
        And match response.products == "#[<expected_products_count>]"
        # * if(response.products.length == 0) karate.call('classpath:helpers/TearDown.feature')
        * if(response.products.length == 0) karate.log('Collection with ID: ' + <collection_id> + " has 0 products")
        Examples:
        | collection_id | expected_products_count |
        | 261236719822  | 2                       |
        | 261810421966  | 0                       |
        | 261177409742  | 1                       |



