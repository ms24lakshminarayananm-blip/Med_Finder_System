<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory"%>
<%@ page import="javax.xml.transform.Transformer, javax.xml.transform.TransformerFactory, javax.xml.transform.dom.DOMSource, javax.xml.transform.stream.StreamResult"%>
<%@ page import="javax.xml.transform.stream.StreamSource"%>
<%@ page import="javax.xml.xpath.XPath, javax.xml.xpath.XPathConstants, javax.xml.xpath.XPathFactory"%>
<%@ page import="org.w3c.dom.Document, org.w3c.dom.NodeList, org.w3c.dom.Element"%>
<%@ page import="java.io.File, java.io.StringWriter"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>XML, DTD, XSD, XSLT &amp; XPath Demo - Medicine Availability Finder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <div class="header-container">
            <div class="logo-group">
                <span class="logo-icon">📄</span>
                <div class="logo-text">
                    <h1>Medicine Availability Finder</h1>
                    <p>XML Processing Suite (Exercise 8A &amp; 8B)</p>
                </div>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="search.jsp">Search Medicines</a></li>
                    <li><a href="feedback.jsp">Feedback</a></li>
                    <li><a href="xmlDemo.jsp" class="active">XML Demo (Ex 8)</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="main-container">
        <h2 class="section-title">📄 Exercise 8 XML / DTD / XSD / XSLT / XPath Demonstrations</h2>

        <%-- Function for XSLT transformation --%>
        <%!
            public String transformXml(String xmlPath, String xslPath) {
                try {
                    File xmlFile = new File(xmlPath);
                    File xslFile = new File(xslPath);
                    if (!xmlFile.exists() || !xslFile.exists()) return "File not found.";

                    TransformerFactory tf = TransformerFactory.newInstance();
                    Transformer transformer = tf.newTransformer(new StreamSource(xslFile));

                    StringWriter writer = new StringWriter();
                    transformer.transform(new StreamSource(xmlFile), new StreamResult(writer));
                    return writer.toString();
                } catch (Exception e) {
                    return "XSLT Error: " + e.getMessage();
                }
            }
        %>

        <!-- 1. EXERCISE 8A: XML FEEDBACK (3-INPUT DTD & 5-INPUT XSD) -->
        <div style="background:#ffffff; border:1px solid var(--border-color); border-radius:8px; padding:1.5rem; margin-bottom:2rem; box-shadow:var(--shadow);">
            <h3 style="color:var(--primary-color); margin-bottom:1rem;">Exercise 8A: XML Feedback Applications</h3>

            <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap:1.5rem;">

                <!-- 3-Input DTD Transformed HTML -->
                <div style="background:#f8fafc; border:1px solid #e2e8f0; padding:1rem; border-radius:6px;">
                    <h4 style="color:#0284c7; margin-bottom:0.5rem;">1. 3-Input XML (feedback.xml + feedback.dtd)</h4>
                    <p style="font-size:0.85rem; color:var(--text-muted); margin-bottom:0.75rem;">Validated via DTD, transformed to HTML table via <code>feedback-dtd.xsl</code>:</p>
                    <div>
                        <%= transformXml(getServletContext().getRealPath("/xml/feedback.xml"), getServletContext().getRealPath("/xsl/feedback-dtd.xsl")) %>
                    </div>
                </div>

                <!-- 5-Input XSD Transformed HTML -->
                <div style="background:#f8fafc; border:1px solid #e2e8f0; padding:1rem; border-radius:6px;">
                    <h4 style="color:#0f766e; margin-bottom:0.5rem;">2. 5-Input XML (feedback-5input.xml + feedback.xsd)</h4>
                    <p style="font-size:0.85rem; color:var(--text-muted); margin-bottom:0.75rem;">Validated via XML Schema (XSD), transformed via <code>feedback-xsd.xsl</code>:</p>
                    <div>
                        <%= transformXml(getServletContext().getRealPath("/xml/feedback-5input.xml"), getServletContext().getRealPath("/xsl/feedback-xsd.xsl")) %>
                    </div>
                </div>

            </div>
        </div>

        <!-- 2. EXERCISE 8B: XML MEDICINE DATABASE & XPATH SEARCHING -->
        <div style="background:#ffffff; border:1px solid var(--border-color); border-radius:8px; padding:1.5rem; margin-bottom:2rem; box-shadow:var(--shadow);">
            <h3 style="color:var(--primary-color); margin-bottom:1rem;">Exercise 8B: XML Medicine Database &amp; XPath Searches</h3>

            <div style="background:#f8fafc; border:1px solid #e2e8f0; padding:1rem; border-radius:6px; margin-bottom:1.5rem;">
                <h4 style="color:var(--text-dark); margin-bottom:0.5rem;">Complete XSLT Transformed Medicine Catalog (medicines.xml + medicines.xsd):</h4>
                <%= transformXml(getServletContext().getRealPath("/xml/medicines.xml"), getServletContext().getRealPath("/xsl/medicines.xsl")) %>
            </div>

            <!-- XPath Filter Demonstration Section -->
            <h4 style="color:var(--text-dark); margin-bottom:0.75rem;">🔍 Execute XPath Expressions against medicines.xml:</h4>

            <div style="display:flex; gap:0.5rem; flex-wrap:wrap; margin-bottom:1.25rem;">
                <a href="xmlDemo.jsp?xpath=available" class="btn btn-sm btn-primary">/medicines/medicine[availability='Available']</a>
                <a href="xmlDemo.jsp?xpath=priceUnder100" class="btn btn-sm btn-success">/medicines/medicine[price &lt; 100]</a>
                <a href="xmlDemo.jsp?xpath=fever" class="btn btn-sm btn-secondary">/medicines/medicine[category='Fever']</a>
                <a href="xmlDemo.jsp" class="btn btn-sm btn-danger">Clear Filter</a>
            </div>

            <%
                String xpathFilter = request.getParameter("xpath");
                if (xpathFilter != null) {
                    String expression = "/medicines/medicine";
                    String queryName = "All Medicines";

                    if ("available".equals(xpathFilter)) {
                        expression = "/medicines/medicine[availability='Available']";
                        queryName = "Available Medicines";
                    } else if ("priceUnder100".equals(xpathFilter)) {
                        expression = "/medicines/medicine[number(price) < 100]";
                        queryName = "Medicines with Price < ₹100";
                    } else if ("fever".equals(xpathFilter)) {
                        expression = "/medicines/medicine[category='Fever']";
                        queryName = "Fever Category Medicines";
                    }

                    try {
                        File xmlFile = new File(getServletContext().getRealPath("/xml/medicines.xml"));
                        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
                        DocumentBuilder db = dbf.newDocumentBuilder();
                        Document doc = db.parse(xmlFile);

                        XPath xPath = XPathFactory.newInstance().newXPath();
                        NodeList nodeList = (NodeList) xPath.evaluate(expression, doc, XPathConstants.NODESET);
            %>
                        <div style="background:#e0f2fe; border:1px solid #0284c7; padding:1rem; border-radius:6px;">
                            <h4 style="color:#0369a1; margin-bottom:0.5rem;">XPath Query Result: <code><%= expression %></code> (<%= nodeList.getLength() %> matches)</h4>
                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Medicine Name</th>
                                            <th>Category</th>
                                            <th>Price (₹)</th>
                                            <th>Availability</th>
                                            <th>Pharmacy</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (int i = 0; i < nodeList.getLength(); i++) {
                                            Element elem = (Element) nodeList.item(i);
                                            String id = elem.getElementsByTagName("id").item(0).getTextContent();
                                            String name = elem.getElementsByTagName("name").item(0).getTextContent();
                                            String cat = elem.getElementsByTagName("category").item(0).getTextContent();
                                            String pr = elem.getElementsByTagName("price").item(0).getTextContent();
                                            String avail = elem.getElementsByTagName("availability").item(0).getTextContent();
                                            String pharm = elem.getElementsByTagName("pharmacy").item(0).getTextContent();
                                        %>
                                            <tr>
                                                <td><%= id %></td>
                                                <td><strong><%= name %></strong></td>
                                                <td><%= cat %></td>
                                                <td>₹<%= pr %></td>
                                                <td><span class="badge badge-available"><%= avail %></span></td>
                                                <td><%= pharm %></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
            <%
                    } catch (Exception e) {
            %>
                        <div class="error-alert">XPath Evaluation Error: <%= e.getMessage() %></div>
            <%
                    }
                }
            %>

        </div>
    </div>

    <footer>
        <p>Medicine Availability Finder &copy; Exercise 8A &amp; 8B: XML Processing</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
