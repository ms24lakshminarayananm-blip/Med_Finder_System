<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medicinefinder.model.Medicine"%>
<%@ page import="com.medicinefinder.dao.PharmacyDAO"%>
<%@ page import="com.medicinefinder.model.Pharmacy"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Medicine Details - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%
        Medicine med = (Medicine) request.getAttribute("medicine");
        if (med == null) {
            response.sendRedirect("search.jsp");
            return;
        }

        PharmacyDAO pharmacyDAO = new PharmacyDAO();
        Pharmacy pharmacy = pharmacyDAO.getPharmacyById(med.getPharmacyId());
    %>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">💊</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>Medicine Specification &amp; Stock Detail</p>
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
        <div class="form-card" style="max-width: 650px;">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1rem;">
                <h2 style="color:var(--primary-color); margin:0;"><%= med.getMedicineName() %></h2>
                <span class="card-category"><%= med.getCategory() %></span>
            </div>

            <div style="background:#f8fafc; border:1px solid #e2e8f0; padding:1.25rem; border-radius:6px; margin-bottom:1.5rem;">
                <p style="font-size:1.4rem; font-weight:bold; color:var(--secondary-color); margin-bottom:0.75rem;">
                    Price: ₹<%= String.format("%.2f", med.getPrice()) %>
                </p>
                <p style="margin-bottom:0.5rem;">
                    <strong>Stock Availability:</strong>
                    <% if (med.getQuantity() > 0) { %>
                        <span class="badge badge-available"><%= med.getQuantity() %> Units Available in Stock</span>
                    <% } else { %>
                        <span class="badge badge-out">Out of Stock</span>
                    <% } %>
                </p>
                <p style="margin-bottom:0.5rem;"><strong>Pharmacy Name:</strong> <%= med.getPharmacyName() %></p>
                <p style="margin-bottom:0.5rem;"><strong>Location:</strong> <%= med.getPharmacyLocation() %></p>
                <% if (pharmacy != null) { %>
                    <p style="margin-bottom:0.5rem;"><strong>Contact Phone:</strong> 📞 <%= pharmacy.getPhone() %></p>
                <% } %>
            </div>

            <form action="cart" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="medicineId" value="<%= med.getId() %>">

                <div class="form-group" style="margin-bottom:1.25rem;">
                    <label for="quantity">Select Quantity:</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" value="1" min="1" max="<%= med.getQuantity() %>" style="max-width:150px;">
                </div>

                <div style="display:flex; gap:1rem;">
                    <button type="submit" class="btn btn-success" style="flex:1;" <%= med.getQuantity() <= 0 ? "disabled" : "" %>>Add to Cart 🛒</button>
                    <a href="search.jsp" class="btn btn-secondary">Back to Search</a>
                </div>
            </form>
        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Exercise 4: medicineDetails.jsp</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
