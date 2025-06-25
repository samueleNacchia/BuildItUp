
package listener;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import static java.time.LocalDateTime.*;
import java.util.concurrent.*;
import model.List.ListDAO;

@WebListener
public class ContextListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
    	
        scheduler = Executors.newSingleThreadScheduledExecutor();

        Runnable dailyTask = () -> {
            try {
                ListDAO list = new ListDAO();
                list.deleteOldList();
            } catch (Exception e) {
                e.printStackTrace(); 
            }
        };
        
        
        long initialDelay = computeInitialDelayInSeconds(3, 0); // parte alle 3:00 AM
        long period = 24*60*60; // ogni 24 ore

        scheduler.scheduleAtFixedRate(dailyTask, initialDelay, period, TimeUnit.SECONDS);
    }
  
    private long computeInitialDelayInSeconds(int targetHour, int targetMinute) {
        java.time.LocalDateTime nextRun = now().withHour(targetHour).withMinute(targetMinute).withSecond(0);
        if (now().compareTo(nextRun) >= 0) {
            nextRun = nextRun.plusDays(1);
        }
        return java.time.Duration.between(now(), nextRun).getSeconds();
    }
    
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    	
    	if (scheduler != null) 
            scheduler.shutdownNow();
    	
    	AbandonedConnectionCleanupThread.checkedShutdown();
    }
}