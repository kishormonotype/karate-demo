Feature: JS execution demo from Karate feature files

    
    Scenario: Exec JS within feature file
        *   def hello_fn = (name) => {return 'Hello ' + name}
        *   print hello_fn('Kishor')
        And match hello_fn('Kishor') == 'Hello Kishor'

    @debug
    Scenario: Execute JS code from another file
        *   def getTodaysDate = read("classpath:helpers/common.js")
        *   def todayDate = getTodaysDate()
        *   print todayDate
        And match todayDate == "03/24/2021"     