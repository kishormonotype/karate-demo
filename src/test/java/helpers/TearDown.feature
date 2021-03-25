Feature: Tear down feature for after actions

    Scenario: After Hook
        * def dataGenerator = Java.type('helpers.FakeDataGenerator')
        * print "After hook: " + dataGenerator.getRandomName()