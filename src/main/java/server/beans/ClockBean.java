package server.beans;

import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Named;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.TextStyle;
import java.util.Locale;

@Getter
@Setter
@RequestScoped
@Named("clockBean")
public class ClockBean implements Serializable {

    private final LocalDateTime dateTime = LocalDateTime.now();

    public String getDate() {
        var dayOfWeek = dateTime.getDayOfWeek().getDisplayName(TextStyle.FULL, new Locale("ru"));
        var dayOfMonth = dateTime.getDayOfMonth();
        var month = dateTime.getMonth().getDisplayName(TextStyle.FULL, new Locale("ru"));
        var year = dateTime.getYear();
        return dayOfWeek + " " + dayOfMonth + " " + month + " " + year;
    }

    public String getTime() {
        return String.format("%02d : %02d : %02d", dateTime.getHour(), dateTime.getMinute(), dateTime.getSecond());
    }

    public int getCurrentRotationAngle() {
        return LocalTime.now().getMinute() * 6;
    }
}


