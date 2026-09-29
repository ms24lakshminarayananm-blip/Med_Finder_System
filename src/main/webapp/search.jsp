<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medicinefinder.model.Medicine"%>
<%@ page import="com.medicinefinder.dao.MedicineDAO"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Medicines - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%
        @SuppressWarnings("unchecked")
        List<Medicine> medicineList = (List<Medicine>) request.getAttribute("medicineList");

        String query = (String) request.getAttribute("searchQuery");
        String category = (String) request.getAttribute("selectedCategory");
        String price = (String) request.getAttribute("maxPrice");

        if (medicineList == null) {
            MedicineDAO dao = new MedicineDAO();
            medicineList = dao.searchMedicines(query, category, (price != null && !price.isEmpty()) ? Double.parseDouble(price) : null);
        }
    %>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">💊</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>Search &amp; Stock Inquiry</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="search.jsp" class="active">Search</a></li>
                    <li><a href="ajaxMedicineSearch.jsp">AJAX Search (Ex 9)</a></li>
                    <li><a href="cart.jsp">Cart 🛒</a></li>
                    <li><a href="home.jsp">Dashboard</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <div class="search-card">
            <h2 class="section-title">
                <span>🔍 Medicine Search &amp; Availability Check</span>
                <a href="ajaxMedicineSearch.jsp" class="btn btn-sm btn-secondary">Switch to AJAX Mode (Ex 9)</a>
            </h2>

            <!-- Form sending data to Servlet (Exercise 3, 4, 5) -->
            <form action="medicine" method="get" class="search-form">
                <div class="form-group">
                    <label for="query">Medicine Name / Keyword:</label>
                    <input type="text" id="query" name="query" class="form-control" placeholder="e.g. Paracetamol" value="<%= query != null ? query : "" %>">
                </div>

                <div class="form-group">
                    <label for="category">Category:</label>
                    <select id="category" name="category" class="form-control">
                        <option value="All" <%= "All".equals(category) ? "selected" : "" %>>All Categories</option>
                        <option value="Fever & Pain" <%= "Fever & Pain".equals(category) ? "selected" : "" %>>Fever &amp; Pain</option>
                        <option value="Antibiotic" <%= "Antibiotic".equals(category) ? "selected" : "" %>>Antibiotic</option>
                        <option value="Allergy" <%= "Allergy".equals(category) ? "selected" : "" %>>Allergy</option>
                        <option value="Gastric" <%= "Gastric".equals(category) ? "selected" : "" %>>Gastric</option>
                        <option value="Cold & Cough" <%= "Cold & Cough".equals(category) ? "selected" : "" %>>Cold &amp; Cough</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="price">Max Price (₹):</label>
                    <input type="number" id="price" name="price" class="form-control" placeholder="e.g. 100" value="<%= price != null ? price : "" %>">
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Search DB</button>
                </div>
            </form>
        </div>

        <h2 class="section-title">📋 Availability Search Results (<%= medicineList.size() %> found)</h2>

        <div class="cards-grid">
            <% if (medicineList.isEmpty()) { %>
                <div style="grid-column: 1 / -1; background: #ffffff; padding: 2rem; border-radius: var(--radius); text-align: center; color: var(--text-muted);">
                    No medicines found matching your criteria. Try adjusting your search query or price filter.
                </div>
            <% } else {
                for (Medicine m : medicineList) { %>
                    <div class="card">
                        <div>
                            <h3 class="card-title"><%= m.getMedicineName() %></h3>
                            <span class="card-category"><%= m.getCategory() %></span>
                            <p class="card-price">₹<%= String.format("%.2f", m.getPrice()) %></p>
                            <p>
                                <strong>Stock:</strong>
                                <% if (m.getQuantity() > 0) { %>
                                    <span class="badge badge-available"><%= m.getQuantity() %> Available</span>
                                <% } else { %>
                                    <span class="badge badge-out">Out of Stock</span>
                                <% } %>
                            </p>
                            <p style="font-size:0.85rem; color: var(--text-muted); margin-top:0.4rem;">
                                <strong>Pharmacy:</strong> <%= m.getPharmacyName() %> (<%= m.getPharmacyLocation() %>)
                            </p>
                        </div>

                        <div style="margin-top: 1.25rem; display: flex; gap: 0.5rem; flex-wrap: wrap;">
                            <a href="medicine?action=details&id=<%= m.getId() %>" class="btn btn-sm btn-secondary">View Details</a>

                            <form action="cart" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="medicineId" value="<%= m.getId() %>">
                                <button type="submit" class="btn btn-sm btn-primary" <%= m.getQuantity() <= 0 ? "disabled" : "" %>>Add to Cart</button>
                            </form>
                        </div>
                    </div>
            <%  } 
            } %>
        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Exercise 4: Servlet + DAO + MySQL Search</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
