package psm;

import org.springframework.web.bind.annotation.*;

@RestController
public class AlertController {

    @GetMapping("/internal/alerts")
    public Object getAlerts() {
        return null;
    }
}
