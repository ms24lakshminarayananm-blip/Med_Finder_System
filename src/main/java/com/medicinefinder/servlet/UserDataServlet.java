package com.medicinefinder.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Exercise 6d: Store Form Data in Session (Name & Email)
 */

public class UserDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");

        HttpSession session = request.getSession();
        session.setAttribute("sessionUserDataName", name);
        session.setAttribute("sessionUserDataEmail", email);

        request.setAttribute("successMessage", "Form data successfully stored in HTTP Session!");
        request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
    }
}
