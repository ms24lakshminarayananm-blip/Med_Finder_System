package com.medicinefinder.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Exercise 6b: Count Page Visits using Cookies ('visitCount')
 */

public class VisitCounterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int visitCount = 1;
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("visitCount".equals(c.getName())) {
                    try {
                        visitCount = Integer.parseInt(c.getValue()) + 1;
                    } catch (NumberFormatException ignored) {}
                    break;
                }
            }
        }

        Cookie visitCookie = new Cookie("visitCount", String.valueOf(visitCount));
        visitCookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
        response.addCookie(visitCookie);

        String format = request.getParameter("format");
        if ("json".equalsIgnoreCase(format)) {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"visitCount\": " + visitCount + "}");
            out.flush();
            return;
        }

        request.setAttribute("visitCount", visitCount);
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}
