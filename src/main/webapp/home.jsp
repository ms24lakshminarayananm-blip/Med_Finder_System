<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medicinefinder.model.User"%>
<%@ page import="com.medicinefinder.dao.OrderDAO"%>
<%@ page import="com.medicinefinder.model.Order"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%
        User currentUser = (User) session.getAttribute("currentUser");
        Integer visitCountAttr = (Integer) request.getAttribute("visitCount");
    %>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">💊</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>User Dashboard</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="home.jsp" class="active">Dashboard</a></li>
                    <li><a href="search.jsp">Search Medicines</a></li>
                    <li><a href="cart.jsp">Cart 🛒</a></li>
                    <li><a href="feedback.jsp">Feedback</a></li>
                    <li><a href="activeUsers">Active Users (Ex 6c)</a></li>
                    <li><a href="logout" class="btn btn-sm btn-danger">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <!-- Welcome Banner & Cookie Visit Counter (Ex 6b) -->
        <div class="welcome-banner">
            <div>
                <% if (currentUser != null) { %>
                    <h2>Welcome, <%= currentUser.getName() %>! 👋</h2>
                    <p>Logged in as: <strong><%= currentUser.getEmail() %></strong></p>
                <% } else { %>
                    <h2>Welcome, Guest User! 👋</h2>
                    <p><a href="login.jsp">Click here to Login</a> for full ordering capabilities.</p>
                <% } %>
            </div>

            <div style="text-align: right;">
                <% if (visitCountAttr != null) { %>
                    <span class="badge badge-available" style="font-size:0.9rem; padding:0.5rem 0.8rem;">
                        📊 Cookie Visit Counter (Ex 6b): You have visited this page <%= visitCountAttr %> times.
                    </span>
                <% } else { %>
                    <a href="visitCounter" class="btn btn-sm btn-primary">Check Visit Counter Cookie (Ex 6b)</a>
                <% } %>
            </div>
        </div>

        <!-- Dashboard Shortcut Cards -->
        <div class="cards-grid">
            <div class="card">
                <h3 class="card-title">🔍 Search Medicines</h3>
                <p>Check availability, prices, and stock across all registered pharmacies.</p>
                <a href="search.jsp" class="btn btn-primary" style="margin-top:1rem;">Go to Search</a>
            </div>

            <div class="card">
                <h3 class="card-title">🛒 Shopping Cart & Orders</h3>
                <p>View items in your cart and complete simulated checkout.</p>
                <a href="cart.jsp" class="btn btn-success" style="margin-top:1rem;">View Cart</a>
            </div>

            <div class="card">
                <h3 class="card-title">⏱️ Session Timeout Demo</h3>
                <p>Test 2-minute inactivity timeout configuration (Ex 6a).</p>
                <a href="sessionTimeout" class="btn btn-secondary" style="margin-top:1rem;">Session Config</a>
            </div>

            <div class="card">
                <h3 class="card-title">🍪 Delete Cookie Demo</h3>
                <p>Demonstrate deleting cookie by setting maxAge to 0 (Ex 6e).</p>
                <a href="deleteCookie?cookieName=visitCount" class="btn btn-danger" style="margin-top:1rem;">Delete Visit Cookie</a>
            </div>
        </div>

        <!-- Recent User Orders Table -->
        <% if (currentUser != null) { 
            OrderDAO orderDAO = new OrderDAO();
            List<Order> userOrders = orderDAO.getOrdersByUserId(currentUser.getId());
        %>
            <h2 class="section-title">📦 Your Order History</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Medicine Name</th>
                            <th>Quantity</th>
                            <th>Total Price (₹)</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (userOrders.isEmpty()) { %>
                            <tr>
                                <td colspan="6" style="text-align:center; color: var(--text-muted);">No orders placed yet.</td>
                            </tr>
                        <% } else {
                            for (Order o : userOrders) { %>
                                <tr>
                                    <td>#<%= o.getId() %></td>
                                    <td><strong><%= o.getMedicineName() %></strong></td>
                                    <td><%= o.getQuantity() %></td>
                                    <td>₹<%= String.format("%.2f", o.getTotalPrice()) %></td>
                                    <td><%= o.getOrderDate() %></td>
                                    <td><span class="badge badge-available"><%= o.getStatus() %></span></td>
                                </tr>
                        <%  } 
                        } %>
                    </tbody>
                </table>
            </div>
        <% } %>

        <!-- Session Data Form (Exercise 6d) -->
        <h2 class="section-title">💾 Store Form Data in Session (Exercise 6d)</h2>
        <div class="search-card" style="max-width: 600px; margin: 0 auto 2rem auto;">
            <p style="margin-bottom:1rem; font-size:0.9rem; color:var(--text-muted);">
                Submit this form to test <code>UserDataServlet</code> storing name & email in <code>session.setAttribute()</code>.
            </p>
            <form action="userData" method="post" class="search-form">
                <div class="form-group">
                    <label>Name:</label>
                    <input type="text" name="name" class="form-control" placeholder="Your Name" value="<%= currentUser != null ? currentUser.getName() : "Demo User" %>">
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" class="form-control" placeholder="Your Email" value="<%= currentUser != null ? currentUser.getEmail() : "user@example.com" %>">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Save to Session</button>
                </div>
            </form>
        </div>

    </div>

    <footer>
        <p>Medicine Availability Finder &copy; User Dashboard (Exercise 4, 5, 6)</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
