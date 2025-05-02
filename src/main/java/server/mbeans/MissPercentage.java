package server.mbeans;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;

@Named
@ApplicationScoped
public class MissPercentage implements MissPercentageMBean {
    @Inject
    private PointStatistics pointStatistics;

    @Override
    public double getMissPercentage() {
        if (pointStatistics.getTotalPoints() == 0) {
            return 0;
        }
        return (double) pointStatistics.getMissedPoints() / pointStatistics.getTotalPoints() * 100;
    }
}
