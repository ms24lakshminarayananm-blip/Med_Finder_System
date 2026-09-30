<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
        <head>
            <title>XML Medicines Database &amp; XPath Filter Transformation</title>
            <style>
                body { font-family: 'Segoe UI', Tahoma, sans-serif; margin: 20px; }
                h2 { color: #0284c7; }
                table { width: 100%; border-collapse: collapse; margin-top: 15px; }
                th, td { border: 1px solid #cbd5e1; padding: 10px; text-align: left; }
                th { background-color: #0284c7; color: white; }
                tr:nth-child(even) { background-color: #f8fafc; }
                .avail { color: #15803d; font-weight: bold; }
                .out { color: #b91c1c; font-weight: bold; }
            </style>
        </head>
        <body>
            <h2>XML Medicine Catalog</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Medicine Name</th>
                    <th>Category</th>
                    <th>Price (₹)</th>
                    <th>Availability</th>
                    <th>Pharmacy Name</th>
                </tr>
                <xsl:for-each select="medicines/medicine">
                    <tr>
                        <td><xsl:value-of select="id"/></td>
                        <td><strong><xsl:value-of select="name"/></strong></td>
                        <td><xsl:value-of select="category"/></td>
                        <td>₹<xsl:value-of select="price"/></td>
                        <td>
                            <xsl:choose>
                                <xsl:when test="availability='Available'">
                                    <span class="avail">Available</span>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span class="out">Out of Stock</span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                        <td><xsl:value-of select="pharmacy"/></td>
                    </tr>
                </xsl:for-each>
            </table>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
