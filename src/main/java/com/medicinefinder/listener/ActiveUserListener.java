package com.medicinefinder.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Exercise 6c: Track currently logged-in / active users using HttpSessionListener.
 */
@WebListener
public class ActiveUserListener implements HttpSessionListener {

    private static final AtomicInteger activeSessions = new AtomicInteger(0);

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        int count = activeSessions.incrementAndGet();
        System.out.println("Session Created. Current Active Sessions: " + count);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        int count = activeSessions.decrementAndGet();
        if (count < 0) {
            activeSessions.set(0);
            count = 0;
        }
        System.out.println("Session Destroyed. Current Active Sessions: " + count);
    }

    public static int getActiveSessions() {
        return activeSessions.get();
    }
}
