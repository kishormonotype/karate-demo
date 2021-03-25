Test project to explore Karate capabilities for API and performance testing.

Installation pre-requisities:
JDK 8 or above
Maven

API tests located at : src/test/java/shopify/feature

Performance tests located at : src/test/java/shopify/performance

Steps to run tests:
1. CD to root dir containing pom.xml
2. Run below commands:
      To run API tests: mvn clean test "-Dkarate.options=--tags @Collections"
      To run performance tests: mvn clean test-compile gatling:test
