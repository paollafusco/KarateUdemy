package conduitApp.performance.createTokens;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import com.intuit.karate.Runner;

public class CreateTokens {

    private static final ArrayList<String> tokens = new ArrayList<>();
    private static final AtomicInteger counter = new AtomicInteger();

    private static String[] emails = {
        "karatedemo01@test.com",
        "karatedemo02@test.com",
        "karatedemo03@test.com"
    };

    public static String getNextToken(){
        return tokens.get(counter.getAndIncrement() % tokens.size());
    }

    public static void createAccessTokens(){

        for(String email: emails) {
            Map<String, Object> account = new HashMap<>();
            account.put("userEmail", email);
            account.put("userPassword", "Welcome01");
            Map<String, Object> result = Runner.runFeature("classpath:helpers/CreateToken.feature", account,true);
            tokens.add(result.get("authToken").toString());
        }
    }
    
}
