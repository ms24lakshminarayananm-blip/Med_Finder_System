<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medicinefinder.model.Order"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%
        @SuppressWarnings("unchecked")
        List<Order> placedOrders = (List<Order>) request.getAttribute("placedOrders");
        Double grandTotal = (Double) request.getAttribute("grandTotal");
        String paymentStatus = (String) request.getAttribute("paymentStatus");

        if (placedOrders == null) {
            response.sendRedirect("home.jsp");
            return;
        }
    %>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">✅</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>Order Placed Successfully</p>
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
        <div class="form-card" style="max-width: 700px; text-align: center;">
            <div style="font-size: 3.5rem; color: var(--accent-color); margin-bottom: 0.5rem;">🎉</div>
            <h2 style="color: var(--accent-color); margin-bottom: 0.5rem;">Order Confirmed!</h2>
            <p style="color: var(--text-muted); margin-bottom: 1.5rem;">
                Thank you for your order. Your medicine reservation and order details have been processed.
            </p>

            <div class="success-alert" style="margin-bottom: 1.5rem; text-align: left;">
                💳 <strong>Payment Status:</strong> <%= paymentStatus != null ? paymentStatus : "Payment Successful (Demo Mode)" %>
            </div>

            <h3 style="text-align: left; margin-bottom: 0.75rem; color: var(--text-dark);">Order Items Detail</h3>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Medicine Name</th>
                            <th>Qty</th>
                            <th>Price (₹)</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order o : placedOrders) { %>
                            <tr>
                                <td>#<%= o.getId() %></td>
                                <td><strong><%= o.getMedicineName() %></strong></td>
                                <td><%= o.getQuantity() %></td>
                                <td>₹<%= String.format("%.2f", o.getTotalPrice()) %></td>
                                <td><span class="badge badge-available"><%= o.getStatus() %></span></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div style="margin-top: 1.5rem; text-align: right;">
                <h3 style="color: var(--text-dark);">Total Amount Paid: <span style="color: var(--secondary-color);">₹<%= String.format("%.2f", grandTotal != null ? grandTotal : 0.0) %></span></h3>
            </div>

            <div style="margin-top: 2rem; display: flex; gap: 1rem; justify-content: center;">
                <a href="home.jsp" class="btn btn-primary">Go to Dashboard</a>
                <a href="search.jsp" class="btn btn-secondary">Search More Medicines</a>
            </div>
        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Real-Time Pharmacy Stock &amp; Price Inquiry System</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
