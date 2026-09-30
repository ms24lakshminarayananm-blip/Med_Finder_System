<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medicinefinder.model.User"%>
<%@ page import="com.medicinefinder.servlet.CartServlet.CartItem"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        double grandTotal = 0;
        for (CartItem item : cart.values()) {
            grandTotal += item.getTotalPrice();
        }
    %>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">💳</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>Order Checkout &amp; Payment (Demo Mode)</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="search.jsp">Search Medicines</a></li>
                    <li><a href="cart.jsp">Cart 🛒</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap:2rem;">

            <!-- Order Summary -->
            <div class="card" style="height:fit-content;">
                <h3 class="section-title">📋 Order Summary</h3>
                <table style="width:100%; margin-bottom:1rem;">
                    <thead>
                        <tr>
                            <th>Medicine</th>
                            <th>Qty</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (CartItem item : cart.values()) { %>
                            <tr>
                                <td><%= item.getMedicine().getMedicineName() %></td>
                                <td><%= item.getQuantity() %></td>
                                <td>₹<%= String.format("%.2f", item.getTotalPrice()) %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                <hr style="margin: 1rem 0; border: none; border-top: 1px solid var(--border-color);">
                <h3 style="display:flex; justify-content:space-between; color:var(--text-dark);">
                    <span>Total Amount Payable:</span>
                    <span style="color:var(--secondary-color);">₹<%= String.format("%.2f", grandTotal) %></span>
                </h3>
            </div>

            <!-- Simulated Payment Form -->
            <div class="card">
                <h3 class="section-title">💳 Simulated Payment Details</h3>

                <div class="success-alert" style="margin-bottom: 1.25rem;">
                    ℹ️ <strong>Demo Mode:</strong> No real payment gateway will be charged. Payment is simulated automatically upon placing order.
                </div>

                <!-- Form invoking confirmOrderPlacement (Ex 2vii confirm dialog) -->
                <form action="cart" method="post" onsubmit="return confirmOrderPlacement(event);">
                    <input type="hidden" name="action" value="placeOrder">

                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label>Delivery Name:</label>
                        <input type="text" class="form-control" value="<%= currentUser.getName() %>" required>
                    </div>

                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label>Delivery Address:</label>
                        <textarea class="form-control" rows="2" placeholder="Enter full delivery address" required>123 College Hostel Road, Block A, City</textarea>
                    </div>

                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label>Select Payment Method:</label>
                        <select class="form-control" id="payMethod">
                            <option value="card">Debit / Credit Card (Simulated)</option>
                            <option value="upi">UPI / GPay / PhonePe (Simulated)</option>
                            <option value="cod">Cash on Delivery</option>
                        </select>
                    </div>

                    <div class="form-group" style="margin-bottom: 1.5rem;">
                        <label>Simulated Card / Account Number:</label>
                        <input type="text" class="form-control" value="4111 2222 3333 4444" placeholder="Enter card number">
                    </div>

                    <button type="submit" class="btn btn-success" style="width:100%; font-size:1.1rem;">Confirm &amp; Place Order (₹<%= String.format("%.2f", grandTotal) %>)</button>
                </form>
            </div>

        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Real-Time Pharmacy Stock &amp; Price Inquiry System</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
