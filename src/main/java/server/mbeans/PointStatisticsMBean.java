package server.mbeans;

public interface PointStatisticsMBean {
    int getTotalPoints();
    int getMissedPoints();
    void addPoint(boolean isHit);
}
