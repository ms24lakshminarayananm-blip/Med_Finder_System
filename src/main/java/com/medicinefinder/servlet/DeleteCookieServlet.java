package com.medicinefinder.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Exercise 6e: Delete Cookie by setting maxAge = 0
 */

public class DeleteCookieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cookieName = request.getParameter("cookieName");
        if (cookieName == null || cookieName.trim().isEmpty()) {
            cookieName = "visitCount";
        }

        Cookie cookie = new Cookie(cookieName, "");
        cookie.setMaxAge(0); // Delete cookie
        cookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        response.addCookie(cookie);

        request.setAttribute("deletedCookieName", cookieName);
        request.setAttribute("successMessage", "Cookie '" + cookieName + "' successfully deleted (maxAge set to 0).");
        request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
    }
}
