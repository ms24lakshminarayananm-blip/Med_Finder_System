/* ==================================================
   MEDICINE AVAILABILITY FINDER SYSTEM - JAVASCRIPT
   Implements Exercise 2 (i - viii), AJAX, Cookies, DOM
   ================================================== */

document.addEventListener("DOMContentLoaded", function () {
    console.log("Medicine Availability Finder Application Loaded.");

    // Exercise 2 (i): CONTENT SLIDER
    initContentSlider();

    // Exercise 2 (ii): RANDOM NUMBER FOR REGISTRATION
    initRandomRegistrationNumber();

    // Exercise 2 (iv): COOKIES - Read and display visitor welcome message
    initVisitorCookie();

    // Exercise 2 (v & vi): DOM MANIPULATION & EVENTS
    initDOMEvents();

    // Exercise 2 (viii): FORM VALIDATION
    initFormValidation();
});

/* ==================================================
   1. CONTENT SLIDER (Exercise 2i)
   ================================================== */
const slideData = [
    {
        title: "Find Your Medicine",
        subtitle: "Search thousands of prescribed and OTC medicines across local pharmacies in real-time."
    },
    {
        title: "Check Availability",
        subtitle: "Instant stock status, quantity checks, and exact pricing before you step out."
    },
    {
        title: "Find Nearby Pharmacy",
        subtitle: "Locate verified partner medical stores, view contact numbers, and get exact directions."
    }
];

let currentSlideIndex = 0;
let slideInterval = null;

function initContentSlider() {
    const titleElem = document.getElementById("sliderTitle");
    const subElem = document.getElementById("sliderSubtitle");

    if (!titleElem || !subElem) return;

    function renderSlide(index) {
        titleElem.textContent = slideData[index].title;
        subElem.textContent = slideData[index].subtitle;
    }

    renderSlide(currentSlideIndex);

    // Automatic slide timer (every 4 seconds)
    slideInterval = setInterval(function () {
        currentSlideIndex = (currentSlideIndex + 1) % slideData.length;
        renderSlide(currentSlideIndex);
    }, 4000);

    const prevBtn = document.getElementById("prevSlideBtn");
    const nextBtn = document.getElementById("nextSlideBtn");

    if (prevBtn) {
        prevBtn.addEventListener("click", function () {
            clearInterval(slideInterval);
            currentSlideIndex = (currentSlideIndex - 1 + slideData.length) % slideData.length;
            renderSlide(currentSlideIndex);
        });
    }

    if (nextBtn) {
        nextBtn.addEventListener("click", function () {
            clearInterval(slideInterval);
            currentSlideIndex = (currentSlideIndex + 1) % slideData.length;
            renderSlide(currentSlideIndex);
        });
    }
}

/* ==================================================
   2. RANDOM NUMBER FOR REGISTRATION (Exercise 2ii)
   ================================================== */
function generateRandomRegNumber() {
    const randomDigits = Math.floor(10000 + Math.random() * 90000); // 5 digits
    return "REG-" + randomDigits;
}

function initRandomRegistrationNumber() {
    const refInput = document.getElementById("regRefNo");
    const refDisplay = document.getElementById("regRefDisplay");

    if (refInput || refDisplay) {
        const generatedNum = generateRandomRegNumber();
        if (refInput) refInput.value = generatedNum;
        if (refDisplay) refDisplay.textContent = generatedNum;
    }

    const genBtn = document.getElementById("genNewRefBtn");
    if (genBtn) {
        genBtn.addEventListener("click", function (e) {
            e.preventDefault();
            const newNum = generateRandomRegNumber();
            if (refInput) refInput.value = newNum;
            if (refDisplay) refDisplay.textContent = newNum;
            alert("New Registration Reference Generated: " + newNum); // Ex 2vii (Alert)
        });
    }
}

/* ==================================================
   3. COOKIE MANAGEMENT & WELCOME MESSAGE (Exercise 2iv)
   ================================================== */
function getCookie(name) {
    const nameEQ = name + "=";
    const ca = document.cookie.split(";");
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i].trim();
        if (c.indexOf(nameEQ) === 0) return decodeURIComponent(c.substring(nameEQ.length, c.length));
    }
    return null;
}

function setCookie(name, value, days) {
    let expires = "";
    if (days) {
        const date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + encodeURIComponent(value) + expires + "; path=/";
}

function initVisitorCookie() {
    const visitorName = getCookie("medicineVisitor");
    const welcomeContainer = document.getElementById("visitorWelcomeMsg");

    if (welcomeContainer) {
        if (visitorName) {
            welcomeContainer.textContent = "Welcome back, " + visitorName.replace(/_/g, " ") + "!";
        } else {
            welcomeContainer.textContent = "Welcome, Visitor! Search medicines and check availability.";
        }
    }
}

/* Demo function to trigger PROMPT for visitor name (Exercise 2vii) */
function promptVisitorName() {
    const name = prompt("Please enter your name for visitor welcome message:", ""); // Ex 2vii (Prompt)
    if (name && name.trim() !== "") {
        setCookie("medicineVisitor", name.trim().replace(/\s+/g, "_"), 7);
        alert("Thank you, " + name + "! Visitor cookie created.");
        initVisitorCookie();
    }
}

/* ==================================================
   4. DOM MANIPULATION & EVENTS (Exercise 2iii, 2v, 2vi)
   ================================================== */
function initDOMEvents() {
    // Ex 2vi: input event on search filter box
    const searchInput = document.getElementById("quickSearchInput");
    if (searchInput) {
        searchInput.addEventListener("input", function (e) {
            const query = e.target.value.toLowerCase();
            const cards = document.querySelectorAll(".medicine-card-item");
            cards.forEach(function (card) {
                const name = card.getAttribute("data-name") || "";
                if (name.toLowerCase().includes(query)) {
                    card.style.display = "block";
                } else {
                    card.style.display = "none";
                }
            });
        });
    }

    // Ex 2vi: mouseover event on featured medicine cards
    const medCards = document.querySelectorAll(".card");
    medCards.forEach(function (card) {
        card.addEventListener("mouseover", function () {
            this.style.borderColor = "#0284c7";
        });
        card.addEventListener("mouseout", function () {
            this.style.borderColor = "#e2e8f0";
        });
    });
}

/* Dynamic display of medicine details (Exercise 2iii & 2v) */
function showMedicineDetailsDynamic(name, category, price, quantity, pharmacy) {
    const container = document.getElementById("dynamicMedDetails");
    if (!container) return;

    // Use DOM createElement, innerHTML, textContent (Ex 2v)
    container.innerHTML = ""; // clear previous

    const card = document.createElement("div");
    card.className = "card";

    const title = document.createElement("h3");
    title.className = "card-title";
    title.textContent = name;

    const cat = document.createElement("span");
    cat.className = "card-category";
    cat.textContent = "Category: " + category;

    const priceElem = document.createElement("p");
    priceElem.className = "card-price";
    priceElem.textContent = "Price: ₹" + parseFloat(price).toFixed(2);

    const availElem = document.createElement("p");
    availElem.innerHTML = "<strong>Stock:</strong> " +
        (parseInt(quantity) > 0 ? "<span class='badge badge-available'>" + quantity + " available</span>" : "<span class='badge badge-out'>Out of stock</span>");

    const pharmElem = document.createElement("p");
    pharmElem.innerHTML = "<strong>Pharmacy:</strong> " + pharmacy;

    card.appendChild(title);
    card.appendChild(cat);
    card.appendChild(priceElem);
    card.appendChild(availElem);
    card.appendChild(pharmElem);

    container.appendChild(card);
    container.scrollIntoView({ behavior: 'smooth' });
}

/* Order Confirmation Dialog (Exercise 2vii) */
function confirmOrderPlacement(event) {
    const confirmed = confirm("Are you sure you want to place this order (Simulated Payment)?"); // Ex 2vii (Confirm)
    if (!confirmed) {
        event.preventDefault();
        return false;
    }
    return true;
}

/* ==================================================
   5. FORM VALIDATION (Exercise 2viii - 7 Validations)
   ================================================== */
function initFormValidation() {
    // Registration Form Validation (5 Rules)
    const regForm = document.getElementById("registrationForm");
    if (regForm) {
        regForm.addEventListener("submit", function (e) {
            const name = document.getElementById("regName").value.trim();
            const email = document.getElementById("regEmail").value.trim();
            const password = document.getElementById("regPassword").value;
            const confirmPassword = document.getElementById("regConfirmPassword").value;
            const phone = document.getElementById("regPhone").value.trim();
            const errDiv = document.getElementById("regError");

            let errors = [];

            // Rule 1: Name required
            if (name === "") {
                errors.push("1. Full Name is required.");
            }

            // Rule 2: Email format regex
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                errors.push("2. Enter a valid email address (e.g. user@domain.com).");
            }

            // Rule 3: Password minimum length (>= 6)
            if (password.length < 6) {
                errors.push("3. Password must be at least 6 characters long.");
            }

            // Rule 4: Confirm password matching
            if (password !== confirmPassword) {
                errors.push("4. Passwords do not match.");
            }

            // Rule 5: Phone number validation (10 digits)
            const phoneRegex = /^[0-9]{10}$/;
            if (phone !== "" && !phoneRegex.test(phone)) {
                errors.push("5. Phone number must be exactly 10 numeric digits.");
            }

            if (errors.length > 0) {
                e.preventDefault();
                if (errDiv) {
                    errDiv.style.display = "block";
                    errDiv.innerHTML = "<strong>Validation Errors:</strong><br>" + errors.join("<br>");
                } else {
                    alert(errors.join("\n"));
                }
                return false;
            }
        });
    }

    // Feedback Form Validation (2 Rules)
    const feedbackForm = document.getElementById("feedbackForm");
    if (feedbackForm) {
        feedbackForm.addEventListener("submit", function (e) {
            const rating = document.getElementById("fbRating").value;
            const comments = document.getElementById("fbComments").value.trim();
            const errDiv = document.getElementById("fbError");

            let errors = [];

            // Rule 6: Rating required
            if (!rating || rating === "") {
                errors.push("1. Rating selection is required.");
            }

            // Rule 7: Comments required & min 5 chars
            if (comments === "" || comments.length < 5) {
                errors.push("2. Comments are required (minimum 5 characters).");
            }

            if (errors.length > 0) {
                e.preventDefault();
                if (errDiv) {
                    errDiv.style.display = "block";
                    errDiv.innerHTML = "<strong>Validation Errors:</strong><br>" + errors.join("<br>");
                } else {
                    alert(errors.join("\n"));
                }
                return false;
            }
        });
    }
}

/* ==================================================
   6. AJAX MEDICINE SEARCH (Exercise 9A & 9B)
   ================================================== */
function performAjaxMedicineSearch() {
    const queryInput = document.getElementById("ajaxSearchInput");
    const categorySelect = document.getElementById("ajaxCategorySelect");
    const priceInput = document.getElementById("ajaxPriceInput");
    const resultsContainer = document.getElementById("ajaxResultsContainer");
    const statusMsg = document.getElementById("ajaxStatusMsg");

    if (!resultsContainer) return;

    const query = queryInput ? queryInput.value.trim() : "";
    const category = categorySelect ? categorySelect.value : "All";
    const price = priceInput ? priceInput.value.trim() : "";

    if (statusMsg) statusMsg.textContent = "Fetching matching medicines via AJAX...";

    const url = "medicine?format=json&query=" + encodeURIComponent(query) +
                "&category=" + encodeURIComponent(category) +
                "&price=" + encodeURIComponent(price);

    fetch(url, {
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
        }
    })
    .then(response => {
        if (!response.ok) throw new Error("HTTP error " + response.status);
        return response.json();
    })
    .then(data => {
        if (statusMsg) statusMsg.textContent = "Found " + data.length + " matching medicine(s).";
        resultsContainer.innerHTML = "";

        if (data.length === 0) {
            resultsContainer.innerHTML = "<p style='color: var(--text-muted);'>No medicines match your search criteria.</p>";
            return;
        }

        data.forEach(m => {
            const card = document.createElement("div");
            card.className = "card";
            card.innerHTML = `
                <h3 class="card-title">${m.name}</h3>
                <span class="card-category">${m.category}</span>
                <p class="card-price">₹${parseFloat(m.price).toFixed(2)}</p>
                <p><strong>Stock:</strong> ${m.quantity > 0 ? `<span class="badge badge-available">${m.quantity} available</span>` : `<span class="badge badge-out">Out of stock</span>`}</p>
                <p style="font-size:0.85rem; color:var(--text-muted); margin-top:0.5rem;"><strong>Pharmacy:</strong> ${m.pharmacyName} (${m.pharmacyLocation})</p>
                <form action="cart" method="post" style="margin-top:0.75rem;">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="medicineId" value="${m.id}">
                    <button type="submit" class="btn btn-primary btn-sm" ${m.quantity <= 0 ? 'disabled' : ''}>Add to Cart</button>
                </form>
            `;
            resultsContainer.appendChild(card);
        });
    })
    .catch(error => {
        console.error("AJAX Error:", error);
        if (statusMsg) statusMsg.textContent = "Error loading medicines via AJAX.";
    });
}

/* ==================================================
   7. AJAX REGISTRATION VALIDATION (Exercise 9C - PHP Demo)
   ================================================== */
function validateRegistrationWithPhpAjax() {
    const name = document.getElementById("regName").value;
    const email = document.getElementById("regEmail").value;
    const password = document.getElementById("regPassword").value;
    const statusDiv = document.getElementById("phpValidationResult");

    if (!statusDiv) return;

    statusDiv.style.display = "block";
    statusDiv.textContent = "Validating credentials with PHP server...";

    const params = "name=" + encodeURIComponent(name) +
                   "&email=" + encodeURIComponent(email) +
                   "&password=" + encodeURIComponent(password);

    fetch("php/validateRegistration.php?" + params)
    .then(res => res.json())
    .then(resData => {
        if (resData.valid) {
            statusDiv.className = "success-alert";
            statusDiv.innerHTML = "<strong>PHP Validation Passed:</strong> " + resData.message;
        } else {
            statusDiv.className = "error-alert";
            statusDiv.innerHTML = "<strong>PHP Validation Failed:</strong><br>" + resData.errors.join("<br>");
        }
    })
    .catch(err => {
        statusDiv.className = "error-alert";
        statusDiv.innerHTML = "PHP Validation Demo: Ensure PHP server is running on port or XAMPP. Standard JS validation will handle submission.";
    });
}
