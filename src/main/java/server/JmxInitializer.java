package server;


import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import server.mbeans.MissPercentage;
import server.mbeans.PointStatistics;

import javax.management.MBeanServer;
import javax.management.ObjectName;
import java.lang.management.ManagementFactory;

@ApplicationScoped
public class JmxInitializer {
    @Inject
    private PointStatistics pointStatistics;

    @Inject
    private MissPercentage missPercentage;

    @PostConstruct
    public void init() {
        try {
            MBeanServer mbs = ManagementFactory.getPlatformMBeanServer();

            ObjectName pointStatsName = new ObjectName("server.mbeans:type=PointStatistics"); // FIX
            mbs.registerMBean(pointStatistics, pointStatsName);
            System.out.println("✅ MBean registered: " + pointStatsName);

            ObjectName missPercName = new ObjectName("server.mbeans:type=MissPercentage");
            mbs.registerMBean(missPercentage, missPercName);
            System.out.println("✅ MBean registered: " + missPercName);

        } catch (Exception e) {
            System.err.println("❌ MBean registration failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}