Feature: Hooks to demo before and after actions

    Background: Before steps
        * def dataGenerator1 = Java.type('helpers.FakeDataGenerator')
        * print dataGenerator1.getRandomName()
        
        # After hooks have a special syntax in karate, this will run after every scenario
        * configure afterScenario = function() {  karate.call('classpath:helpers/TearDown.feature')   }

        # * configure afterFeature = function(){ karate.call('after-feature.feature'); }

    Scenario: Before Hook
        * print "This is before scenario"

    Scenario: After Hook
        * print "This is after scenario"