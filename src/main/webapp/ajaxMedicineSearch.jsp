<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dynamic AJAX Medicine Search - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">⚡</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>Dynamic AJAX Search Application</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="search.jsp">Search Medicines</a></li>
                    <li><a href="ajaxMedicineSearch.jsp" class="active">AJAX Search</a></li>
                    <li><a href="cart.jsp">Cart 🛒</a></li>
                    <li><a href="feedback.jsp">Feedback</a></li>
                    <li><a href="xmlDemo.jsp">XML Demo</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <div class="search-card">
            <h2 class="section-title">⚡ Real-Time AJAX Medicine Inquiry</h2>
            <p style="color:var(--text-muted); margin-bottom:1.25rem; font-size:0.9rem;">
                As you type or change filters below, JavaScript <code>fetch()</code> sends an asynchronous request to <code>MedicineServlet</code> (or PHP endpoint) and updates the DOM dynamically <strong>without reloading the page</strong>.
            </p>

            <div class="search-form">
                <div class="form-group">
                    <label for="ajaxSearchInput">Medicine Name / Keyword:</label>
                    <input type="text" id="ajaxSearchInput" class="form-control" placeholder="Type name (e.g. Paracetamol, Cough)..." oninput="performAjaxMedicineSearch()">
                </div>

                <div class="form-group">
                    <label for="ajaxCategorySelect">Category:</label>
                    <select id="ajaxCategorySelect" class="form-control" onchange="performAjaxMedicineSearch()">
                        <option value="All">All Categories</option>
                        <option value="Fever & Pain">Fever &amp; Pain</option>
                        <option value="Antibiotic">Antibiotic</option>
                        <option value="Allergy">Allergy</option>
                        <option value="Gastric">Gastric</option>
                        <option value="Cold & Cough">Cold &amp; Cough</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="ajaxPriceInput">Max Price (₹):</label>
                    <input type="number" id="ajaxPriceInput" class="form-control" placeholder="e.g. 100" oninput="performAjaxMedicineSearch()">
                </div>

                <div class="form-group">
                    <button type="button" onclick="performAjaxMedicineSearch()" class="btn btn-primary">Search AJAX (Servlet)</button>
                </div>
            </div>
        </div>

        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1rem;">
            <div id="ajaxStatusMsg" style="font-weight:600; color:var(--primary-color);">Ready to search.</div>
            <div>
                <!-- PHP Endpoint Demonstration Button -->
                <button type="button" onclick="fetchFromPhpEndpoint()" class="btn btn-sm btn-secondary">Test PHP Endpoint (php/medicineData.php)</button>
            </div>
        </div>

        <!-- Dynamic Results Container -->
        <div id="ajaxResultsContainer" class="cards-grid">
            <p style="color: var(--text-muted); grid-column: 1/-1;">Start typing a medicine name above to load real-time availability via AJAX...</p>
        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Real-Time Pharmacy Stock &amp; Price Inquiry System</p>
    </footer>

    <script src="js/script.js"></script>
    <script>
        // Trigger initial search on page load
        document.addEventListener("DOMContentLoaded", function() {
            performAjaxMedicineSearch();
        });

        // Exercise 9B: Fetch from PHP endpoint demo
        function fetchFromPhpEndpoint() {
            const container = document.getElementById("ajaxResultsContainer");
            const status = document.getElementById("ajaxStatusMsg");
            status.textContent = "Fetching medicine JSON from php/medicineData.php...";

            fetch("php/medicineData.php")
            .then(res => res.json())
            .then(data => {
                status.textContent = "Loaded " + data.length + " medicines from PHP backend endpoint.";
                container.innerHTML = "";
                data.forEach(m => {
                    const card = document.createElement("div");
                    card.className = "card";
                    card.innerHTML = `
                        <h3 class="card-title">${m.name}</h3>
                        <span class="card-category">${m.category}</span>
                        <p class="card-price">₹${parseFloat(m.price).toFixed(2)}</p>
                        <p><span class="badge badge-available">${m.availability}</span></p>
                        <p style="font-size:0.85rem; color:var(--text-muted); margin-top:0.5rem;"><strong>Pharmacy:</strong> ${m.pharmacy}</p>
                    `;
                    container.appendChild(card);
                });
            })
            .catch(err => {
                status.textContent = "PHP Demo: Run via XAMPP or PHP web server to test php/medicineData.php endpoint directly.";
                console.log("PHP Endpoint notice:", err);
            });
        }
    </script>
</body>
</html>
