package server.beans;

import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.SessionScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import lombok.Getter;
import lombok.Setter;
import server.DatabaseManager;
import server.mbean.MissRatio;
import server.mbean.ShotStats;
import server.models.Point;

import javax.management.MBeanServer;
import javax.management.ObjectName;
import java.io.Serializable;
import java.lang.management.ManagementFactory;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Getter
@Setter
@SessionScoped
@Named("areaCheck")
public class AreaBean implements Serializable {

    @Inject
    private DatabaseManager db;

    private double x;
    private double y;
    private double r;
    private boolean hit;

    private List<Integer> XValues = Arrays.asList(-3, -2, -1, 0, 1, 2, 3, 4, 5);
    private List<Point> points;

    // Ссылки на MBean'ы
    private transient ShotStats shotStats;

    @PostConstruct
    public void init() {
        x = 0;
        y = 0;
        r = 5;

        if (points == null) {
            points = new ArrayList<>();
        }
        points = db.getPoints();

        // Регистрация MBeans
        try {
            MBeanServer mbs = ManagementFactory.getPlatformMBeanServer();

            shotStats = new ShotStats();
            MissRatio missRatio = new MissRatio(shotStats);

            ObjectName shotStatsName = new ObjectName("ru.ackey:type=ShotStats");
            ObjectName missRatioName = new ObjectName("ru.ackey:type=MissRatio");

            if (!mbs.isRegistered(shotStatsName)) {
                mbs.registerMBean(shotStats, shotStatsName);
            }
            if (!mbs.isRegistered(missRatioName)) {
                mbs.registerMBean(missRatio, missRatioName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String submit() {
        hit = checkHit();
        Point point = new Point(x, y, r, hit);
        points.add(point);
        db.addPoint(point);

        if (shotStats != null) {
            shotStats.registerShot(hit);
        }

        return null;
    }

    public void clear() {
        points.clear();
        db.clearTable();
    }

    private boolean checkHit() {
        if (x <= 0 && y >= 0 && y <= 0.5 * x + r / 2) return true;
        if (x * x + y * y <= r * r && x >= 0 && y >= 0) return true;
        return x <= 0 && y <= 0 && x >= -r / 2 && y >= -r;
    }

    // optimization
    public String getSvgPoints() {
        StringBuilder sb = new StringBuilder();
        for (Point point : points) {
            int cx = (int)(point.getX() * 40 + 250);
            int cy = (int)(-point.getY() * 40 + 250);
            String color = point.isHit() ? "green" : "red";
            sb.append(String.format("<circle r=\"5\" cx=\"%d\" cy=\"%d\" fill=\"%s\"/>", cx, cy, color));
        }
        return sb.toString();
    }

}