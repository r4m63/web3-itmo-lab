import org.junit.jupiter.api.Test;
import server.beans.ClockBean;

import java.util.regex.Pattern;

import static org.junit.jupiter.api.Assertions.assertTrue;

class ClockBeanTest {

    @Test
    void testGetDateFormat() {
        ClockBean clock = new ClockBean();
        String date = clock.getDate();
        // Ожидаем шаблон: <день недели на русском> <число> <месяц на русском> <год>
        // Например: "понедельник 17 мая 2025"
        String regex = "[\\p{IsCyrillic}]+ \\d{1,2} [\\p{IsCyrillic}]+ \\d{4}";
        assertTrue(Pattern.matches(regex, date), "Date должно соответствовать формату «день месяц год» на русском");
    }

    @Test
    void testGetTimeFormat() {
        ClockBean clock = new ClockBean();
        String time = clock.getTime();
        // Формат "HH : mm : ss"
        assertTrue(Pattern.matches("\\d{2} : \\d{2} : \\d{2}", time), "Time должно быть в формате HH : mm : ss");
    }

    @Test
    void testGetCurrentRotationAngle() {
        ClockBean clock = new ClockBean();
        int angle = clock.getCurrentRotationAngle();
        // Минута от 0 до 59, угол = минута * 6
        assertTrue(angle % 6 == 0, "Угол должен быть кратен 6");
        assertTrue(angle >= 0 && angle < 360, "Угол в диапазоне [0,360)");
    }
}
