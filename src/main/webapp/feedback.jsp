<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medicinefinder.model.Feedback"%>
<%@ page import="com.medicinefinder.dao.FeedbackDAO"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback &amp; Reviews - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%
        @SuppressWarnings("unchecked")
        List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");
        if (feedbackList == null) {
            FeedbackDAO dao = new FeedbackDAO();
            feedbackList = dao.getAllFeedback();
        }
    %>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">⭐</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>User Feedback &amp; Review System</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="search.jsp">Search Medicines</a></li>
                    <li><a href="feedback.jsp" class="active">Feedback</a></li>
                    <li><a href="xmlDemo.jsp">XML Feedback View (Ex 8A)</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap:2rem;">

            <!-- Feedback Form -->
            <div class="card">
                <h3 class="section-title">💬 Submit Your Feedback</h3>

                <!-- Error Alert Box for JS Form Validation (Ex 2viii Rule 6 & 7) -->
                <div id="fbError" class="error-alert" style="display:none;"></div>

                <%
                    String error = (String) request.getAttribute("errorMessage");
                    if (error != null) {
                %>
                    <div class="error-alert"><%= error %></div>
                <%
                    }
                %>

                <form action="feedback" method="post" id="feedbackForm">
                    <div class="form-group" style="margin-bottom:1rem;">
                        <label for="fbName">Your Name *:</label>
                        <input type="text" id="fbName" name="name" class="form-control" placeholder="Enter your full name" required>
                    </div>

                    <div class="form-group" style="margin-bottom:1rem;">
                        <label for="fbEmail">Email Address:</label>
                        <input type="email" id="fbEmail" name="email" class="form-control" placeholder="e.g. user@example.com">
                    </div>

                    <!-- Rule 6: Rating required -->
                    <div class="form-group" style="margin-bottom:1rem;">
                        <label for="fbRating">Rating (1 to 5 Stars) *:</label>
                        <select id="fbRating" name="rating" class="form-control" required>
                            <option value="">-- Select Rating --</option>
                            <option value="5">5 Stars ★★★★★ (Excellent)</option>
                            <option value="4">4 Stars ★★★★☆ (Good)</option>
                            <option value="3">3 Stars ★★★☆☆ (Average)</option>
                            <option value="2">2 Stars ★★☆☆☆ (Needs Improvement)</option>
                            <option value="1">1 Star ★☆☆☆☆ (Poor)</option>
                        </select>
                    </div>

                    <!-- Rule 7: Comments required -->
                    <div class="form-group" style="margin-bottom:1.5rem;">
                        <label for="fbComments">Comments / Feedback *:</label>
                        <textarea id="fbComments" name="comments" class="form-control" rows="4" placeholder="Share your experience finding medicine availability..." required></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width:100%;">Submit Feedback</button>
                </form>
            </div>

            <!-- Recent Feedbacks List -->
            <div class="card">
                <h3 class="section-title">
                    <span>🌟 Recent Community Feedback</span>
                    <a href="xmlDemo.jsp" class="btn btn-sm btn-secondary">View XML XSLT (Ex 8A)</a>
                </h3>

                <div style="max-height: 450px; overflow-y: auto; display:flex; flex-direction:column; gap:1rem;">
                    <% if (feedbackList.isEmpty()) { %>
                        <p style="color: var(--text-muted); text-align: center;">No feedback submitted yet.</p>
                    <% } else {
                        for (Feedback f : feedbackList) { %>
                            <div style="background:#f8fafc; border:1px solid var(--border-color); padding:1rem; border-radius:6px;">
                                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:0.35rem;">
                                    <strong><%= f.getName() %></strong>
                                    <span style="color:#d97706; font-weight:bold;"><%= f.getRating() %> ★</span>
                                </div>
                                <p style="font-size:0.9rem; color:var(--text-dark);"><%= f.getComments() %></p>
                                <span style="font-size:0.75rem; color:var(--text-muted); display:block; margin-top:0.4rem;">Submitted on: <%= f.getFeedbackDate() %></span>
                            </div>
                    <%  }
                    } %>
                </div>
            </div>

        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Exercise 5 &amp; 8A: Feedback System</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
