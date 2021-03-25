package helpers;

import com.github.javafaker.Faker;

public class FakeDataGenerator {

    private static Faker faker;

    static{
        faker = new Faker();
    }

    public static String getUniqueCollectionName(){
        String name = faker.name().name() + faker.random().nextInt(0, 100);
        return name;
    }

    public static String getRandomName(){
        return faker.gameOfThrones().character();
    }
    
}
