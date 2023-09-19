package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import com.intuit.karate.junit5.Karate;

class ConduitTest1 {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp")
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    
}
