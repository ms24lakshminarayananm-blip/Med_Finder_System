# FACULTY DEMONSTRATION GUIDE
> **Medicine Availability Finder System - Step-by-Step Lab Presentation Guide**

Follow this exact sequence during your lab evaluation to demonstrate Exercises 1 through 9 smoothly to your faculty.

---

## 🏁 Step-by-Step Demo Sequence

### Step 1: Homepage & UI (Exercise 1 & 2)
1. Open `http://localhost:8080/MedicineAvailabilityFinder/index.html`.
2. **Ex 1 (HTML/CSS):** Show custom medical-themed styling (no Bootstrap). Point out header navigation, quick search section, featured cards, partner pharmacies grid, and footer.
3. **Ex 2i (Content Slider):** Click the **❮ Previous** and **Next ❯** buttons on the hero banner or let the automatic 4-second timer slide the titles.
4. **Ex 2iv & 2vii (Cookies & Prompt):** Click the **Set Name (Cookie Demo)** button on the top welcome bar. When the JavaScript `prompt()` appears, enter your name. Show the updated welcome message storing visitor cookie (`medicineVisitor`).
5. **Ex 2iii & 2v (DOM Manipulation):** Click **View Dynamic (Ex 2iii)** on any featured card. Show how `document.createElement()` dynamically builds a medicine detail card at the bottom of the page.
6. **Ex 2vi (Events):** Type in the "Filter cards (JS Input Event)" box next to Featured Medicines to demonstrate real-time `input` event filtering. Hover over cards to show `mouseover` border highlights.

---

### Step 2: Registration & Validation (Exercise 2ii, 2viii, 4, 9C)
1. Click **Register** from the navigation bar (`register.jsp`).
2. **Ex 2ii (Random Ref No):** Point out the dynamically generated reference number (e.g. `REG-48321`). Click **Generate New** to show `alert()` with a fresh number.
3. **Ex 2viii (Form Validation):** Click **Submit Registration** with blank fields. Point out the inline validation errors enforcing 5 rules:
   - Full Name required
   - Email format regex (`user@domain.com`)
   - Password minimum 6 characters
   - Passwords match confirmation
   - 10-digit numeric phone number
4. **Ex 9C (PHP AJAX Check):** Fill in the form and click **PHP AJAX Check (Ex 9C)** to demonstrate AJAX calling `php/validateRegistration.php` and returning live JSON validation.
5. Submit valid details to register a new user into MySQL database.

---

### Step 3: Login & Database Authentication (Exercise 3 & 4)
1. Click **Login** (`login.jsp`).
2. Enter demo credentials:
   - **Email:** `user@example.com`
   - **Password:** `password123`
3. Click **Login**. Explain the request flow:
   `login.jsp` ➔ `LoginServlet.java` (doPost) ➔ `UserDAO` / JDBC (`PreparedStatement`) ➔ MySQL `users` table ➔ Session set (`currentUser`) ➔ Redirect to `home.jsp`.

---

### Step 4: Search & Servlet GET/POST (Exercise 3, 4, 5)
1. On `home.jsp` or navigation bar, click **Search Medicines** (`search.jsp`).
2. Enter keyword `"Paracetamol"` or filter by category `"Fever & Pain"` and max price `100`.
3. Click **Search DB**. Explain the flow:
   `search.jsp` ➔ `MedicineServlet.java` (doGet) ➔ `MedicineDAO` ➔ MySQL `medicines` table ➔ `search.jsp` rendering results.
4. Click **View Details** on any medicine to view `medicineDetails.jsp`.

---

### Step 5: Ecommerce Cart & Order Checkout (Exercise 7 & Ex 2vii)
1. On `search.jsp` or `medicineDetails.jsp`, select quantity (e.g. `2`) and click **Add to Cart 🛒**.
2. View `cart.jsp`. Show items in HTTP session cart, unit prices, subtotal, and grand total.
3. Click **Proceed to Checkout 💳** (`checkout.jsp`).
4. Fill delivery address and click **Confirm & Place Order**.
5. **Ex 2vii (Confirm Dialog):** Point out the JavaScript `confirm()` modal: *"Are you sure you want to place this order (Simulated Payment)?"*.
6. Click **OK**. Show `orderConfirmation.jsp` displaying placed order details, simulated payment confirmation status, and updated MySQL `orders` table & stock deduction.

---

### Step 6: Session & Cookie Features (Exercise 6a - 6e)
1. Navigate back to **Dashboard** (`home.jsp`).
2. **Ex 6b (Visit Counter Cookie):** Click **Check Visit Counter Cookie (Ex 6b)**. Show the visit count incrementing on each refresh (`visitCount` cookie).
3. **Ex 6c (Active Users):** Click **Active Users (Ex 6c)** (`activeUsers.jsp`). Show live session count tracked by `ActiveUserListener` (`HttpSessionListener`).
4. **Ex 6d (Session Form Data):** Scroll down to "Store Form Data in Session" on `home.jsp`. Submit name & email. Show `UserDataServlet` saving data into `session.setAttribute()` and displaying on `confirmation.jsp`.
5. **Ex 6e (Delete Cookie):** Click **Delete Visit Cookie**. Show `DeleteCookieServlet` setting `maxAge = 0` to delete cookie.
6. **Ex 6a (Session Timeout):** Click **Session Config** (`sessionTimeout`). Show `web.xml` 2-minute configuration `<session-timeout>2</session-timeout>`. Click **Simulate 2-Min Expiry Now** to view `timeout.jsp`.

---

### Step 7: XML, DTD, XSD, XSLT & XPath (Exercise 8A & 8B)
1. Open **XML Demo (Ex 8)** (`xmlDemo.jsp`).
2. **Ex 8A (Feedback XML):** Show the two transformed tables:
   - 3-Input Feedback XML (`feedback.xml` validated against `feedback.dtd`) transformed via `feedback-dtd.xsl`.
   - 5-Input Feedback XML (`feedback-5input.xml` validated against `feedback.xsd`) transformed via `feedback-xsd.xsl`.
3. **Ex 8B (Medicine Database XML & XPath):**
   - View the transformed medicine catalog table (`medicines.xml` validated against `medicines.xsd` transformed via `medicines.xsl`).
   - Click the live XPath filter buttons:
     - `/medicines/medicine[availability='Available']`
     - `/medicines/medicine[price < 100]`
     - `/medicines/medicine[category='Fever']`
   - Show matching XML nodes evaluated dynamically via Java `javax.xml.xpath.XPath`.

---

### Step 8: Real-Time AJAX Search (Exercise 9A & 9B)
1. Click **AJAX Search (Ex 9)** (`ajaxMedicineSearch.jsp`).
2. Type `"Amoxicillin"` in the input box.
3. Point out that the medicine list updates **instantly without any full page refresh**.
4. Explain the AJAX architecture:
   Input event ➔ JS `fetch()` ➔ `MedicineServlet?format=json` ➔ JSON response ➔ Dynamic DOM rendering.
5. Click **Test PHP Endpoint (php/medicineData.php)** to demonstrate fetching medicine JSON from the PHP backend endpoint (Ex 9B).
