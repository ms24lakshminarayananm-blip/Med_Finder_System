<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">💊</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>User Authentication System</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="search.jsp">Search Medicines</a></li>
                    <li><a href="login.jsp" class="active">Login</a></li>
                    <li><a href="register.jsp">Register</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <div class="form-card">
            <h2>🔐 User Login</h2>

            <%
                String error = (String) request.getAttribute("errorMessage");
                String success = (String) request.getAttribute("successMessage");
                String logout = request.getParameter("logout");

                if (error != null) {
            %>
                <div class="error-alert"><%= error %></div>
            <%
                }
                if (success != null) {
            %>
                <div class="success-alert"><%= success %></div>
            <%
                }
                if ("true".equals(logout)) {
            %>
                <div class="success-alert">You have been logged out successfully!</div>
            <%
                }
            %>

            <!-- HTML Form sending data to Servlet (Exercise 3 & 4) -->
            <form action="login" method="post" id="loginForm">
                <div class="form-group" style="margin-bottom: 1rem;">
                    <label for="email">Email Address:</label>
                    <input type="email" id="email" name="email" class="form-control" required placeholder="e.g. user@example.com" value="user@example.com">
                </div>

                <div class="form-group" style="margin-bottom: 1.5rem;">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required placeholder="Enter password" value="password123">
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%;">Login</button>
            </form>

            <p style="text-align: center; margin-top: 1.25rem; font-size: 0.9rem;">
                Don't have an account? <a href="register.jsp">Register Here</a>
            </p>
            <p style="text-align: center; margin-top: 0.5rem; font-size: 0.85rem; color: var(--text-muted);">
                Demo Credentials: <strong>user@example.com</strong> / <strong>password123</strong>
            </p>
        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Real-Time Pharmacy Stock &amp; Price Inquiry System</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
