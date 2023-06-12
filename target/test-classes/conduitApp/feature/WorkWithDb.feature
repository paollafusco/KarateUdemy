
Feature: Work with DB

Background: connect to db
    * def dbHandler = Java.type('helpers.DbHandler')


Scenario: Seed database with a new Job
    * eval dbHandler.addNewJobWithName("QA9")


Scenario: Get level for Job
    * def level = dbHandler.getMinAndMaxLevelsForJob("QA9")    
    * print level.minLvL 
    * print level.maxLvL
    And match level.minLvL == '80'
    And match level.maxLvL == '120'