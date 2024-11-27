package server.beans;

import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.SessionScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import lombok.Getter;
import lombok.Setter;
import server.DatabaseManager;
import server.models.Point;

import java.io.Serializable;
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

    @PostConstruct
    public void init() { // вызов | объект создан + все зависимости
        x = 0;
        y = 0;
        r = 5;
        if (points == null) {
            points = new ArrayList<>();
        }
        points = db.getPoints();
    }

    public String submit() {
        hit = checkHit();
        Point point = new Point(x, y, r, hit);
        points.add(point);
        db.addPoint(point);
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
}
