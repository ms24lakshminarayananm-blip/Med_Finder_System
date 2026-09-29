package com.medicinefinder.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Exercise 6a: Session Timeout Management & Demo Trigger
 */

public class SessionTimeoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(true);

        // Set session timeout to exactly 2 minutes (120 seconds) as per Ex 6a
        session.setMaxInactiveInterval(120);

        if ("testExpire".equalsIgnoreCase(action)) {
            // Immediate expiration demonstration without forcing 2-minute wait
            session.invalidate();
            request.setAttribute("timeoutMessage", "Session manually invalidated to simulate 2-minute inactivity timeout.");
            request.getRequestDispatcher("/timeout.jsp").forward(request, response);
            return;
        }

        request.setAttribute("message", "Session timeout is configured to 2 minutes (120 seconds). Inactive sessions will automatically expire.");
        request.getRequestDispatcher("/timeout.jsp").forward(request, response);
    }
}
