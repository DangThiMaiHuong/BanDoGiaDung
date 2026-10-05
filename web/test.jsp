<%-- 
    Document   : test
    Created on : Oct 5, 2026, 1:33:15 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>TEST DATABASE</h1>

        <%
            try {
                Connect db = new Connect();
                Connection conn = db.getConnection();

                if (conn != null) {
                    out.println("<h2>MYSQL CONNECT OK</h2>");
                    conn.close();
                } else {
                    out.println("<h2>MYSQL CONNECT FAILED</h2>");
                }
            } catch (Exception e) {
                out.println("<h2>MYSQL ERROR</h2>");
                out.println("<pre>" + e.toString() + "</pre>");
            }
        %>
    </body>
</html>
