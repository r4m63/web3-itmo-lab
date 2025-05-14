package server.mbean;

public class MissRatio implements MissRatioMBean {

    private final ShotStats shotStats;

    public MissRatio(ShotStats stats) {
        this.shotStats = stats;
    }

    @Override
    public double getMissRatio() {
        int total = shotStats.getTotalShots();
        if (total == 0) return 0.0;
        return (double) shotStats.getMisses() / total * 100;
    }
}

