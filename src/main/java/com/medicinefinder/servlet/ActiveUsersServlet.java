package com.medicinefinder.servlet;

import com.medicinefinder.listener.ActiveUserListener;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Exercise 6c: Track and display currently logged-in / active users count.
 */

public class ActiveUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int activeCount = ActiveUserListener.getActiveSessions();
        request.setAttribute("activeUsersCount", activeCount);
        request.getRequestDispatcher("/activeUsers.jsp").forward(request, response);
    }
}
