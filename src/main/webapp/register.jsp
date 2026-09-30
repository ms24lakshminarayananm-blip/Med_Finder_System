<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Registration - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">💊</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>New User Registration</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="search.jsp">Search Medicines</a></li>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="register.jsp" class="active">Register</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <div class="form-card" style="max-width: 550px;">
            <h2>📝 User Registration</h2>

            <!-- Random Registration Reference Number -->
            <div style="background:#e0f2fe; padding:0.75rem; border-radius:6px; margin-bottom:1rem; text-align:center;">
                <strong>Registration Ref No:</strong>
                <span id="regRefDisplay" style="color:#0284c7; font-weight:bold; font-size:1.1rem;">REG-00000</span>
                <button type="button" id="genNewRefBtn" class="btn btn-sm btn-secondary" style="margin-left:0.5rem;">Generate New</button>
            </div>

            <!-- Dynamic Error Alert Box for JS Validation -->
            <div id="regError" class="error-alert" style="display: none;"></div>

            <!-- PHP Validation Result Box -->
            <div id="phpValidationResult" style="display: none;"></div>

            <%
                String error = (String) request.getAttribute("errorMessage");
                if (error != null) {
            %>
                <div class="error-alert"><%= error %></div>
            <%
                }
            %>

            <!-- Registration Form with JS Validation submitting to RegisterServlet -->
            <form action="register" method="post" id="registrationForm">
                <input type="hidden" id="regRefNo" name="refNo" value="">

                <div class="form-group" style="margin-bottom: 1rem;">
                    <label for="regName">Full Name *:</label>
                    <input type="text" id="regName" name="name" class="form-control" placeholder="e.g. John Doe">
                </div>

                <div class="form-group" style="margin-bottom: 1rem;">
                    <label for="regEmail">Email Address *:</label>
                    <input type="email" id="regEmail" name="email" class="form-control" placeholder="e.g. john@example.com">
                </div>

                <div class="form-group" style="margin-bottom: 1rem;">
                    <label for="regPassword">Password (Min 6 chars) *:</label>
                    <input type="password" id="regPassword" name="password" class="form-control" placeholder="At least 6 characters">
                </div>

                <div class="form-group" style="margin-bottom: 1rem;">
                    <label for="regConfirmPassword">Confirm Password *:</label>
                    <input type="password" id="regConfirmPassword" name="confirmPassword" class="form-control" placeholder="Re-enter password">
                </div>

                <div class="form-group" style="margin-bottom: 1.5rem;">
                    <label for="regPhone">Mobile Phone (10 digits):</label>
                    <input type="text" id="regPhone" name="phone" class="form-control" placeholder="e.g. 9876543210">
                </div>

                <div style="display:flex; gap:0.5rem;">
                    <button type="submit" class="btn btn-success" style="flex:1;">Submit Registration</button>
                    <!-- PHP Validation Check Button -->
                    <button type="button" onclick="validateRegistrationWithPhpAjax()" class="btn btn-secondary" style="flex:1;">PHP AJAX Check</button>
                </div>
            </form>

            <p style="text-align: center; margin-top: 1.25rem; font-size: 0.9rem;">
                Already registered? <a href="login.jsp">Login Here</a>
            </p>
        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Real-Time Pharmacy Stock &amp; Price Inquiry System</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
