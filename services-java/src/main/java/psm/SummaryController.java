package psm;

import org.springframework.web.bind.annotation.*;

@RestController
public class SummaryController {

    @GetMapping("/internal/summary")
    public Object getSummary() {
        return null;
    }
}
