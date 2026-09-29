package com.medicinefinder.servlet;

import com.medicinefinder.dao.UserDAO;
import com.medicinefinder.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward GET request to login.jsp
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email and Password are required!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.authenticateUser(email.trim(), password.trim());

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getName());

            // Set visitor cookie (Exercise 2 / Exercise 6)
            Cookie userCookie = new Cookie("medicineVisitor", user.getName().replaceAll("\\s+", "_"));
            userCookie.setMaxAge(60 * 60 * 24 * 7); // 7 days
            response.addCookie(userCookie);

            response.sendRedirect(request.getContextPath() + "/home.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username/email or password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
