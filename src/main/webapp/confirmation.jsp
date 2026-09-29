<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Confirmation - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">ℹ️</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>Operation Confirmation</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="home.jsp">Dashboard</a></li>
                    <li><a href="search.jsp">Search Medicines</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <div class="form-card" style="max-width: 600px; text-align: center;">

            <%
                String successMsg = (String) request.getAttribute("successMessage");
                String userSubmittedName = (String) request.getAttribute("userSubmittedName");
                String userSubmittedEmail = (String) request.getAttribute("userSubmittedEmail");
                String deletedCookieName = (String) request.getAttribute("deletedCookieName");

                String sessionName = (String) session.getAttribute("sessionUserDataName");
                String sessionEmail = (String) session.getAttribute("sessionUserDataEmail");
            %>

            <div style="font-size: 3rem; margin-bottom: 0.5rem;">👍</div>
            <h2 style="color: var(--primary-color); margin-bottom: 1rem;">Action Completed</h2>

            <% if (successMsg != null) { %>
                <div class="success-alert" style="margin-bottom: 1.5rem;"><%= successMsg %></div>
            <% } %>

            <!-- Exercise 6d: Display Form Data Stored in Session -->
            <% if (sessionName != null || sessionEmail != null) { %>
                <div style="background:#f1f5f9; border:1px solid var(--border-color); padding:1rem; border-radius:6px; margin-bottom:1.5rem; text-align:left;">
                    <h3 style="color:var(--secondary-color); margin-bottom:0.5rem;">💾 Data Stored in Session (Exercise 6d):</h3>
                    <p><strong>Name:</strong> <%= sessionName != null ? sessionName : "N/A" %></p>
                    <p><strong>Email:</strong> <%= sessionEmail != null ? sessionEmail : "N/A" %></p>
                </div>
            <% } %>

            <!-- Exercise 6e: Delete Cookie Confirmation -->
            <% if (deletedCookieName != null) { %>
                <div style="background:#fee2e2; color:#b91c1c; padding:1rem; border-radius:6px; margin-bottom:1.5rem; text-align:left;">
                    <strong>🍪 Cookie Deletion (Exercise 6e):</strong><br>
                    Cookie <code><%= deletedCookieName %></code> maxAge was set to 0 and deleted from response headers.
                </div>
            <% } %>

            <div style="display:flex; gap:1rem; justify-center; margin-top:1.5rem;">
                <a href="home.jsp" class="btn btn-primary" style="flex:1;">Return to Dashboard</a>
                <a href="search.jsp" class="btn btn-secondary" style="flex:1;">Search Medicines</a>
            </div>
        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Exercise 5 &amp; 6 Confirmation Page</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
