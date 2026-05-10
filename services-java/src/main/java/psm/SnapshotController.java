package psm;

import org.springframework.web.bind.annotation.*;

@RestController
public class SnapshotController {

    @PostMapping("/internal/snapshots")
    public void receiveSnapshot(@RequestBody Object snapshot) {
        // TODO: handle snapshot
    }
}
