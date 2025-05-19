import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import server.DatabaseManager;
import server.beans.AreaBean;
import server.mbean.ShotStats;
import server.models.Point;

import javax.management.MBeanServer;
import javax.management.ObjectName;
import java.lang.management.ManagementFactory;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class AreaBeanTest {

    private AreaBean bean;
    private DatabaseManager db;

    @BeforeEach
    void setUp() throws Exception {
        db = mock(DatabaseManager.class);
        when(db.getPoints()).thenReturn(new ArrayList<>());

        bean = new AreaBean();
        bean.setDb(db);

        MBeanServer mbs = ManagementFactory.getPlatformMBeanServer();
        for (String type : new String[]{"ShotStats", "MissRatio"}) {
            ObjectName name = new ObjectName("ru.ackey:type=" + type);
            if (mbs.isRegistered(name)) {
                mbs.unregisterMBean(name);
            }
        }

        bean.init();
        bean.getPoints().clear();
    }

    @Test
    void testInitDefaults() {
        assertEquals(0, bean.getX());
        assertEquals(0, bean.getY());
        assertEquals(5, bean.getR());
        verify(db).getPoints();
        assertNotNull(bean.getPoints());
        assertTrue(bean.getPoints().isEmpty());
        assertNotNull(bean.getShotStats());
    }

    @Test
    void testSubmitRegistersHitAndStoresPoint() {
        bean.setX(-1);
        bean.setY(1);
        bean.setR(5);

        String result = bean.submit();
        assertNull(result);

        List<Point> pts = bean.getPoints();
        assertEquals(1, pts.size());
        Point p = pts.get(0);
        assertEquals(-1, p.getX());
        assertEquals(1, p.getY());
        assertEquals(5, p.getR());
        assertTrue(p.isHit());

        ArgumentCaptor<Point> cap = ArgumentCaptor.forClass(Point.class);
        verify(db).addPoint(cap.capture());
        assertEquals(p, cap.getValue());

        ShotStats stats = bean.getShotStats();
        assertEquals(1, stats.getTotalShots());
        assertEquals(1, stats.getHits());
    }

    @Test
    void testSubmitRegistersMissAndStoresPoint() {
        bean.setX(5);
        bean.setY(5);
        bean.setR(5);

        bean.submit();
        Point p = bean.getPoints().get(0);
        assertFalse(p.isHit());
        verify(db).addPoint(any());
        assertEquals(1, bean.getShotStats().getTotalShots());
        assertEquals(0, bean.getShotStats().getHits());
    }

    @Test
    void testClear() {
        bean.getPoints().add(new Point(0, 0, 1, true));
        bean.clear();
        assertTrue(bean.getPoints().isEmpty());
        verify(db).clearTable();
    }

    @Test
    void testGetSvgPoints() {
        bean.getPoints().add(new Point(1, 1, 5, true));
        bean.getPoints().add(new Point(-1, -1, 5, false));
        String svg = bean.getSvgPoints();
        assertTrue(svg.contains("fill=\"green\""));
        assertTrue(svg.contains("fill=\"red\""));
        assertTrue(svg.contains("cx=\"290\"") && svg.contains("cy=\"210\""));
    }

    //=== Detailed coverage of checkHit() ===//

    // 1. Upper-left triangular region: x ≤ 0, y ≥ 0, y ≤ 0.5 * x + r/2

    @Test
    void region1_strictlyInside() {
        bean.setR(5);
        bean.setX(-4);
        bean.setY(0.5);
        bean.submit();
        assertTrue(lastPoint().isHit());
    }

    @Test
    void region1_onBoundary() {
        bean.setR(8);
        bean.setX(-6);
        bean.setY(1); // 0.5 * (-6) + 4 = 1
        bean.submit();
        assertTrue(lastPoint().isHit());
    }

    @Test
    void region1_justOutside() {
        bean.setR(5);
        bean.setX(-4);
        bean.setY(0.6);
        bean.submit();
        assertFalse(lastPoint().isHit());
    }

    // 2. Quarter-circle in 1st quadrant: x ≥ 0, y ≥ 0, x^2 + y^2 ≤ r^2

    @Test
    void region2_strictlyInside() {
        bean.setR(10);
        bean.setX(6);
        bean.setY(8); // 6^2 + 8^2 = 100 = 10^2
        bean.submit();
        assertTrue(lastPoint().isHit());
    }

    @Test
    void region2_onCircleBoundary() {
        bean.setR(5);
        bean.setX(3);
        bean.setY(4); // 3^2 + 4^2 = 25 = 5^2
        bean.submit();
        assertTrue(lastPoint().isHit());
    }

    @Test
    void region2_justOutsideCircle() {
        bean.setR(5);
        bean.setX(3);
        bean.setY(4.1);
        bean.submit();
        assertFalse(lastPoint().isHit());
    }

    @Test
    void region2_negativeY_miss() {
        bean.setR(5);
        bean.setX(2);
        bean.setY(-1);
        bean.submit();
        assertFalse(lastPoint().isHit());
    }

    // 3. Lower-left rectangular region: x ≤ 0, y ≤ 0, x ≥ -r/2, y ≥ -r

    @Test
    void region3_strictlyInside() {
        bean.setR(6);
        bean.setX(-3);
        bean.setY(-4);
        bean.submit();
        assertTrue(lastPoint().isHit());
    }

    @Test
    void region3_onBoundaryX() {
        bean.setR(8);
        bean.setX(-4); // -r/2 = -4
        bean.setY(-2);
        bean.submit();
        assertTrue(lastPoint().isHit());
    }

    @Test
    void region3_onBoundaryY() {
        bean.setR(8);
        bean.setX(-2);
        bean.setY(-8); // y = -r
        bean.submit();
        assertTrue(lastPoint().isHit());
    }

    @Test
    void region3_justOutsideX() {
        bean.setR(6);
        bean.setX(-3.1);
        bean.setY(-1);
        bean.submit();
        assertFalse(lastPoint().isHit());
    }

    @Test
    void region3_justOutsideY() {
        bean.setR(6);
        bean.setX(-1);
        bean.setY(-6.1);
        bean.submit();
        assertFalse(lastPoint().isHit());
    }

    // 4. Generic misses outside all regions

    @Test
    void generic_miss_positiveQuadrantOutsideCircle() {
        bean.setR(5);
        bean.setX(4);
        bean.setY(4);
        bean.submit();
        assertFalse(lastPoint().isHit());
    }

    @Test
    void generic_miss_mixedQuadrants() {
        bean.setR(5);
        bean.setX(1);
        bean.setY(-2);
        bean.submit();
        assertFalse(lastPoint().isHit());
    }

    // Helper to fetch last point
    private Point lastPoint() {
        List<Point> pts = bean.getPoints();
        assertFalse(pts.isEmpty(), "No points recorded");
        return pts.get(pts.size() - 1);
    }
}
