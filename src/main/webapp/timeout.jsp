<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Session Timeout - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">⏱️</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>Session Timeout Management (Exercise 6a)</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="sessionTimeout" class="active">Session Timeout Demo</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <div class="form-card" style="max-width: 600px; text-align: center;">

            <%
                String timeoutMsg = (String) request.getAttribute("timeoutMessage");
                String generalMsg = (String) request.getAttribute("message");
            %>

            <div style="font-size: 3.5rem; color: var(--danger-color); margin-bottom: 0.5rem;">⌛</div>
            <h2 style="color: var(--danger-color); margin-bottom: 1rem;">Session Expiration Status</h2>

            <div class="error-alert" style="margin-bottom: 1.5rem; text-align: left; font-size: 1rem;">
                ⚠️ <strong>Session Timeout Notice:</strong><br>
                <%= timeoutMsg != null ? timeoutMsg : "Your session has expired due to 2 minutes of inactivity. Please login again." %>
            </div>

            <div style="background:#f8fafc; border:1px solid var(--border-color); padding:1rem; border-radius:6px; text-align:left; font-size:0.9rem; margin-bottom:1.5rem;">
                <strong>⚙️ Technical Configuration (Exercise 6a):</strong>
                <ul style="margin-left:1.25rem; margin-top:0.4rem;">
                    <li>Configured in <code>web.xml</code>: <code>&lt;session-timeout&gt;2&lt;/session-timeout&gt;</code> (2 minutes).</li>
                    <li>Programmatically set in <code>SessionTimeoutServlet</code>: <code>session.setMaxInactiveInterval(120);</code>.</li>
                </ul>
            </div>

            <div style="display:flex; gap:1rem;">
                <a href="sessionTimeout?action=testExpire" class="btn btn-danger" style="flex:1;">Simulate 2-Min Expiry Now</a>
                <a href="login.jsp" class="btn btn-primary" style="flex:1;">Login Again</a>
            </div>
        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Exercise 6a: Session Timeout Feature</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
