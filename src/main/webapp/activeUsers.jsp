<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medicinefinder.listener.ActiveUserListener"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Active Logged-in Users - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%
        Integer activeCountAttr = (Integer) request.getAttribute("activeUsersCount");
        int activeCount = (activeCountAttr != null) ? activeCountAttr : ActiveUserListener.getActiveSessions();
    %>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">👥</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>Live Active Users Monitor (Exercise 6c)</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="home.jsp">Dashboard</a></li>
                    <li><a href="activeUsers" class="active">Active Users</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <div class="form-card" style="max-width: 600px; text-align: center;">
            <div style="font-size: 3rem; margin-bottom: 0.5rem;">🟢</div>
            <h2 style="color: var(--primary-color); margin-bottom: 1rem;">Active Sessions Tracker</h2>

            <div style="background:#e0f2fe; border:2px solid #0284c7; padding:2rem; border-radius:8px; margin-bottom:1.5rem;">
                <p style="font-size:1.1rem; color:#0369a1; margin-bottom:0.5rem;">Currently Active Users / HTTP Sessions:</p>
                <span style="font-size:3.5rem; font-weight:bold; color:var(--primary-color);"><%= activeCount %></span>
                <p style="font-size:0.85rem; color:var(--text-muted); margin-top:0.5rem;">Tracked via <code>ActiveUserListener</code> (HttpSessionListener)</p>
            </div>

            <div style="background:#f8fafc; border:1px solid var(--border-color); padding:1rem; border-radius:6px; text-align:left; font-size:0.9rem;">
                <strong>💡 How it works (Exercise 6c):</strong>
                <ul style="margin-left:1.25rem; margin-top:0.4rem;">
                    <li><code>ActiveUserListener</code> implements <code>HttpSessionListener</code> interface.</li>
                    <li>Increments <code>AtomicInteger</code> counter whenever <code>sessionCreated()</code> fires.</li>
                    <li>Decrements counter whenever <code>sessionDestroyed()</code> fires.</li>
                </ul>
            </div>

            <div style="margin-top:1.5rem; display:flex; gap:1rem;">
                <a href="activeUsers" class="btn btn-primary" style="flex:1;">Refresh Count</a>
                <a href="home.jsp" class="btn btn-secondary" style="flex:1;">Dashboard</a>
            </div>
        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Exercise 6c: Track Currently Logged-in Users</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
