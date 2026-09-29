<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
        <head>
            <title>Feedback Summary (DTD Validated)</title>
            <style>
                table { width: 100%; border-collapse: collapse; font-family: sans-serif; }
                th, td { border: 1px solid #cbd5e1; padding: 10px; text-align: left; }
                th { background-color: #0284c7; color: white; }
                tr:nth-child(even) { background-color: #f8fafc; }
            </style>
        </head>
        <body>
            <h2>Feedback Summary (3-Input XML transformed via XSLT / DTD)</h2>
            <table>
                <tr>
                    <th>User Name</th>
                    <th>Rating</th>
                    <th>Comments</th>
                </tr>
                <xsl:for-each select="feedbacks/feedback">
                    <tr>
                        <td><xsl:value-of select="name"/></td>
                        <td><xsl:value-of select="rating"/> / 5 ★</td>
                        <td><xsl:value-of select="comments"/></td>
                    </tr>
                </xsl:for-each>
            </table>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
