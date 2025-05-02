package server.mbeans;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Named;

import javax.management.Notification;
import javax.management.NotificationBroadcasterSupport;

@Named
@ApplicationScoped
public class PointStatistics extends NotificationBroadcasterSupport implements PointStatisticsMBean {
    private int totalPoints = 0;
    private int missedPoints = 0;
    private int consecutiveMisses = 0;
    private long sequenceNumber = 1;

    @Override
    public int getTotalPoints() {
        return totalPoints;
    }

    @Override
    public int getMissedPoints() {
        return missedPoints;
    }

    @Override
    public void addPoint(boolean isHit) {
        totalPoints++;
        if (!isHit) {
            missedPoints++;
            consecutiveMisses++;
            if (consecutiveMisses >= 2) {
                sendNotification(new Notification(
                        "twoConsecutiveMisses",
                        this,
                        sequenceNumber++,
                        System.currentTimeMillis(),
                        "User missed 2 times in a row"
                ));
                consecutiveMisses = 0;
            }
        } else {
            consecutiveMisses = 0;
        }
    }
}
