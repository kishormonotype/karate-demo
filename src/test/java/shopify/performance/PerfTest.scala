package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {
  
  /*
    Run this simulation using command : mvn clean test-compile gatling:test
  */

  val protocol = karateProtocol(
      // "/admin/api/2021-01/custom_collections/{collection_id}" -> Nil
  )

  val csvFeeder = csv("collectionNames.csv").circular

  val createCollection = scenario("createCollection")
            .exec(karateFeature("classpath:shopify/performance/CreateCollection.feature"))
  
  val createCollectionDataDriven = scenario("createCollection")
            .feed(csvFeeder)
            .exec(karateFeature("classpath:shopify/performance/CreateCollectionDataDriven.feature"))

        

  setUp(
    createCollection.inject(
        atOnceUsers(1),
        nothingFor(4.seconds),
        rampUsers(5).during(10.seconds)
        // ,constantUsersPerSec(20).during(15.seconds)
        ).protocols(protocol)

    // createCollectionDataDriven.inject(
    //     atOnceUsers(1),
    //     nothingFor(4.seconds),
    //     rampUsers(5).during(10.seconds)
    //     ).protocols(protocol)
  )

}