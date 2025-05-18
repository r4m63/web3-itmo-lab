package server.mbean;

import javax.management.Notification;
import javax.management.NotificationBroadcasterSupport;
import java.util.concurrent.atomic.AtomicInteger;

public class ShotStats extends NotificationBroadcasterSupport implements ShotStatsMBean {

    private final AtomicInteger totalShots = new AtomicInteger(0);
    private final AtomicInteger misses = new AtomicInteger(0);
    private int consecutiveMisses = 0;
    private long sequenceNumber = 1;

    public synchronized void registerShot(boolean hit) {
        totalShots.incrementAndGet();
        if (!hit) {
            misses.incrementAndGet();
            consecutiveMisses++;
            if (consecutiveMisses >= 2) {
                Notification notif = new Notification(
                        "consecutive.misses",
                        this,
                        sequenceNumber++,
                        System.currentTimeMillis(),
                        "User made 2 consecutive misses."
                );
                sendNotification(notif);
                consecutiveMisses = 0;
            }
        } else {
            consecutiveMisses = 0;
        }
    }

    @Override
    public int getTotalShots() {
        return totalShots.get();
    }

    @Override
    public int getMisses() {
        return misses.get();
    }

    /**
     * Количество попаданий (hits) = всего выстрелов минус промахи.
     */
    @Override
    public int getHits() {
        return totalShots.get() - misses.get();
    }
}

