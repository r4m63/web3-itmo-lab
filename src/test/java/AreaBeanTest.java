import org.junit.jupiter.api.Test;
import server.beans.AreaBean;

import static org.junit.jupiter.api.Assertions.*;

public class AreaBeanTest {

    @Test
    public void testCheckHitFirstQuadrant() {
        AreaBean bean = new AreaBean();
        bean.setX(1);
        bean.setY(1);
        bean.setR(2);
        assertTrue(bean.checkHit());
    }

    @Test
    public void testCheckHitSecondQuadrant() {
        AreaBean bean = new AreaBean();
        bean.setX(-1);
        bean.setY(0.5);
        bean.setR(2);
        assertTrue(bean.checkHit());
    }

    @Test
    public void testCheckHitThirdQuadrant() {
        AreaBean bean = new AreaBean();
        bean.setX(-0.5);
        bean.setY(-1);
        bean.setR(2);
        assertTrue(bean.checkHit());
    }
}