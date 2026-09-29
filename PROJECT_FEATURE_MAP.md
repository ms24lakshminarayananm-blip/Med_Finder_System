# PROJECT FEATURE MAP - EXERCISES 1 TO 9
> **Medicine Availability Finder System - 3rd Year CSE Web Technology Lab**

| Exercise | Requirement | File(s) | How to Demonstrate |
| :--- | :--- | :--- | :--- |
| **Ex 1** | Design Simple Webpage using HTML & CSS | `index.html`, `css/style.css` | Open `index.html`. View header, nav, search section, featured medicine grid, pharmacy info, and footer without external CSS frameworks. |
| **Ex 2i** | Content Slider | `js/script.js`, `index.html` | Click Next/Previous buttons or watch automatic timer slide titles & subtitles on homepage. |
| **Ex 2ii** | Random Registration Ref Number | `js/script.js`, `register.jsp` | Open `register.jsp`. Observe dynamic reference number (`REG-XXXXX`) generated on load / click of "Generate New". |
| **Ex 2iii** | Dynamic Content Display | `js/script.js`, `index.html` | Click "View Dynamic (Ex 2iii)" on any featured medicine card on homepage to render DOM card element dynamically. |
| **Ex 2iv** | Cookies Visitor Welcome | `js/script.js`, `index.html`, `LoginServlet.java` | Login or click "Set Name (Cookie Demo)" on homepage. Cookie `medicineVisitor` stores name and displays welcome message. |
| **Ex 2v** | DOM Manipulation Methods | `js/script.js` | Uses `getElementById`, `querySelector`, `innerHTML`, `textContent`, `value`, `createElement` across homepage and search pages. |
| **Ex 2vi** | Event Handling | `js/script.js` | Demonstrates `click` (slider/btns), `submit` (forms), `change` (filters), `input` (search card filter), `mouseover` (card border glow). |
| **Ex 2vii** | Alert, Prompt, Confirm | `js/script.js`, `checkout.jsp` | `alert()` on ref generation, `prompt()` for visitor name, `confirm()` dialog when placing order on `checkout.jsp`. |
| **Ex 2viii** | Form Validation (7 Rules) | `js/script.js`, `register.jsp`, `feedback.jsp` | Submit empty registration/feedback forms. Clear inline error messages enforce name, email format, min pass, pass match, phone, rating, comments. |
| **Ex 3** | Servlet Basics (GET & POST) | `LoginServlet.java`, `MedicineServlet.java`, `web.xml` | HTML search/login forms submit data to servlets. Servlets process parameters (`request.getParameter`), set attributes, and use `PrintWriter`/forwarding. |
| **Ex 4** | Login + JSP + MySQL | `login.jsp`, `register.jsp`, `home.jsp`, `search.jsp`, `LoginServlet.java`, `UserDAO.java` | Register a user or login with `user@example.com`/`password123`. Authenticates via JDBC `PreparedStatement` against MySQL `users` table. |
| **Ex 5** | 2 Servlets + 3 or More JSP Pages | All `servlet/*.java`, all `*.jsp` | Application contains 11 Servlets and 12 JSPs integrated into a cohesive navigation flow. |
| **Ex 6a** | Session Timeout (2 Mins) | `SessionTimeoutServlet.java`, `timeout.jsp`, `web.xml` | Configured `<session-timeout>2</session-timeout>` in `web.xml`. Click "Session Config" or "Simulate 2-Min Expiry Now" to test. |
| **Ex 6b** | Count Page Visits using Cookie | `VisitCounterServlet.java`, `home.jsp` | Click "Check Visit Counter Cookie" on dashboard. Cookie `visitCount` increments on every page visit. |
| **Ex 6c** | Track Active Logged-in Users | `ActiveUserListener.java`, `ActiveUsersServlet.java`, `activeUsers.jsp` | Visit `activeUsers.jsp` or click "Active Users". Uses `HttpSessionListener` to track live active user session count. |
| **Ex 6d** | Store Form Data in Session | `UserDataServlet.java`, `home.jsp`, `confirmation.jsp` | Fill name & email form under "Store Form Data in Session" on dashboard. Stores in `session.setAttribute()` and displays on `confirmation.jsp`. |
| **Ex 6e** | Delete Cookie (maxAge = 0) | `DeleteCookieServlet.java`, `home.jsp`, `confirmation.jsp` | Click "Delete Visit Cookie" on dashboard. Sets `maxAge(0)` to remove cookie and shows confirmation. |
| **Ex 7** | Ecommerce Cart & Simulated Order | `cart.jsp`, `checkout.jsp`, `orderConfirmation.jsp`, `CartServlet.java`, `OrderDAO.java` | Search medicine -> Add to Cart -> Adjust qty -> Checkout -> Simulated payment -> Save order in MySQL `orders` table -> Confirmation. |
| **Ex 8A** | XML Feedback (DTD & XSD) | `xml/feedback.xml`, `xml/feedback.dtd`, `xml/feedback-5input.xml`, `xml/feedback.xsd`, `xsl/feedback-dtd.xsl`, `xsl/feedback-xsd.xsl`, `xmlDemo.jsp` | Visit `xmlDemo.jsp`. Displays 3-input DTD-validated XML and 5-input XSD-validated XML transformed into HTML tables via XSLT. |
| **Ex 8B** | XML Medicine Database & XPath | `xml/medicines.xml`, `xml/medicines.xsd`, `xsl/medicines.xsl`, `xmlDemo.jsp` | Visit `xmlDemo.jsp`. Shows XSLT transformed medicine XML table and tests live XPath queries (`[availability='Available']`, `[price < 100]`, `[category='Fever']`). |
| **Ex 9A** | AJAX Medicine Search | `ajaxMedicineSearch.jsp`, `js/script.js`, `MedicineServlet.java` | Open `ajaxMedicineSearch.jsp`. Type medicine name. JS `fetch()` retrieves JSON from `MedicineServlet` and updates DOM without page reload. |
| **Ex 9B** | Dynamic AJAX Web App (PHP Demo) | `ajaxMedicineSearch.jsp`, `php/medicineData.php` | Click "Test PHP Endpoint" on `ajaxMedicineSearch.jsp` to fetch medicine JSON from PHP backend. |
| **Ex 9C** | AJAX + PHP Registration Validation | `register.jsp`, `js/script.js`, `php/validateRegistration.php` | Fill registration inputs on `register.jsp` and click "PHP AJAX Check". Returns live PHP JSON validation response. |
