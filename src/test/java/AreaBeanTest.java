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
        // Подменяем DatabaseManager и очищаем MBeanServer от наших имён
        db = mock(DatabaseManager.class);
        // Вернём пустой список при init
        when(db.getPoints()).thenReturn(new ArrayList<>());

        bean = new AreaBean();
        bean.setDb(db);

        // Удаляем зарегистрированные MBeans от прошлых запусков
        MBeanServer mbs = ManagementFactory.getPlatformMBeanServer();
        for (String type : new String[]{"ShotStats", "MissRatio"}) {
            ObjectName name = new ObjectName("ru.ackey:type=" + type);
            if (mbs.isRegistered(name)) {
                mbs.unregisterMBean(name);
            }
        }

        bean.init();
    }

    @Test
    void testInitDefaults() {
        assertEquals(0, bean.getX());
        assertEquals(0, bean.getY());
        assertEquals(5, bean.getR());
        // После init points = getPoints()
        verify(db).getPoints();
        assertNotNull(bean.getPoints());
        assertTrue(bean.getPoints().isEmpty());
        assertNotNull(bean.getShotStats());
    }

    @Test
    void testSubmitRegistersHitAndStoresPoint() {
        // Зададим параметры, которые попадают в первую ветку checkHit
        bean.setX(-1);
        bean.setY(1);
        bean.setR(5);

        String result = bean.submit();
        assertNull(result, "submit() всегда возвращает null");

        // Проверяем, что в points появился новый Point
        List<Point> pts = bean.getPoints();
        assertEquals(1, pts.size());
        Point p = pts.get(0);
        assertEquals(-1, p.getX());
        assertEquals(1, p.getY());
        assertEquals(5, p.getR());
        assertTrue(p.isHit());

        // Проверяем, что в БД добавили ту же точку
        ArgumentCaptor<Point> cap = ArgumentCaptor.forClass(Point.class);
        verify(db).addPoint(cap.capture());
        assertEquals(p, cap.getValue());

        // Проверяем, что в shotStats зарегистрирован выстрел
        ShotStats stats = bean.getShotStats();
        assertEquals(1, stats.getTotalShots());
        assertEquals(1, stats.getHits());
    }

    @Test
    void testSubmitRegistersMissAndStoresPoint() {
        // Зададим параметры промаха (например, x=5,y=5 вне круга r=5)
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
        // Подготовим ненулевой список
        bean.getPoints().add(new Point(0, 0, 1, true));
        bean.clear();
        assertTrue(bean.getPoints().isEmpty());
        verify(db).clearTable();
    }

    @Test
    void testCheckHitRegions() {
        bean.setR(2);
        // Верхняя левая область
        bean.setX(-1);
        bean.setY(0.4);
        assertTrue(bean.submit() == null && bean.getPoints().get(bean.getPoints().size() - 1).isHit());

        // Круг в первой четверти
        bean.getPoints().clear();
        bean.setX(1);
        bean.setY(1);
        assertTrue(bean.submit() == null && bean.getPoints().get(0).isHit());

        // Нижняя левая область
        bean.getPoints().clear();
        bean.setX(-0.5);
        bean.setY(-1);
        assertTrue(bean.submit() == null && bean.getPoints().get(0).isHit());

        // Промах
        bean.getPoints().clear();
        bean.setX(2);
        bean.setY(-2);
        bean.submit();
        assertFalse(bean.getPoints().get(0).isHit());
    }

    @Test
    void testGetSvgPoints() {
        bean.getPoints().clear();
        // Добавим два разных
        bean.getPoints().add(new Point(1, 1, 5, true));
        bean.getPoints().add(new Point(-1, -1, 5, false));
        String svg = bean.getSvgPoints();
        // Проверим, что для hit и miss цвета разные и координаты считаются верно
        assertTrue(svg.contains("fill=\"green\""));
        assertTrue(svg.contains("fill=\"red\""));
        assertTrue(svg.contains("cx=\"290\"") && svg.contains("cy=\"210\""));  // 1*40+250, -1*40+250 = 210
    }
}
