<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medicinefinder.servlet.CartServlet.CartItem"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        double grandTotal = 0;
    %>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">💊</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>Shopping Cart</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="search.jsp">Search Medicines</a></li>
                    <li><a href="ajaxMedicineSearch.jsp">AJAX Search</a></li>
                    <li><a href="cart.jsp" class="active">Cart 🛒</a></li>
                    <li><a href="feedback.jsp">Feedback</a></li>
                    <li><a href="xmlDemo.jsp">XML Demo</a></li>
                    <li><a href="home.jsp">Dashboard</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <h2 class="section-title">🛒 Your Shopping Cart</h2>

        <%
            String error = (String) request.getAttribute("errorMessage");
            if (error != null) {
        %>
            <div class="error-alert"><%= error %></div>
        <%
            }
        %>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Medicine Name</th>
                        <th>Pharmacy</th>
                        <th>Price (₹)</th>
                        <th>Quantity</th>
                        <th>Subtotal (₹)</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (cart == null || cart.isEmpty()) { %>
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 2rem; color: var(--text-muted);">
                                Your cart is currently empty. <br>
                                <a href="search.jsp" class="btn btn-sm btn-primary" style="margin-top: 0.75rem;">Browse &amp; Search Medicines</a>
                            </td>
                        </tr>
                    <% } else {
                        for (CartItem item : cart.values()) {
                            grandTotal += item.getTotalPrice();
                    %>
                        <tr>
                            <td><strong><%= item.getMedicine().getMedicineName() %></strong></td>
                            <td><%= item.getMedicine().getPharmacyName() %></td>
                            <td>₹<%= String.format("%.2f", item.getMedicine().getPrice()) %></td>
                            <td><%= item.getQuantity() %></td>
                            <td>₹<%= String.format("%.2f", item.getTotalPrice()) %></td>
                            <td>
                                <a href="cart?action=remove&id=<%= item.getMedicine().getId() %>" class="btn btn-sm btn-danger">Remove</a>
                            </td>
                        </tr>
                    <%  } 
                    } %>
                </tbody>
            </table>
        </div>

        <% if (cart != null && !cart.isEmpty()) { %>
            <div style="display:flex; justify-content:space-between; align-items:center; background:#ffffff; padding:1.5rem; border-radius:var(--radius); box-shadow:var(--shadow);">
                <div>
                    <h3 style="color:var(--text-dark);">Grand Total: <span style="color:var(--secondary-color);">₹<%= String.format("%.2f", grandTotal) %></span></h3>
                </div>
                <div style="display:flex; gap:1rem;">
                    <a href="search.jsp" class="btn btn-secondary">Continue Shopping</a>
                    <a href="cart?action=checkout" class="btn btn-success">Proceed to Checkout 💳</a>
                </div>
            </div>
        <% } %>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Real-Time Pharmacy Stock &amp; Price Inquiry System</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
