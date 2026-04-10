<%-- 
    Document   : cart
    Created on : Apr 6, 2026, 8:07:19 PM
    Author     : PC
--%>

<%@page import="java.util.List"%>
<%@page import="Model.Product"%>
<%@page import="Model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="style.css" rel="stylesheet" type="text/css"/>

<jsp:include page="Layout/header.jsp"/>
<jsp:include page="Layout/menu.jsp"/>

<div class="main">

    <jsp:include page="Layout/left.jsp"/>

    <div class="content">
        <%
            List<Product> cart = (List<Product>) session.getAttribute("cart");
            double total = 0;
        %>

        <h2>Giỏ hàng</h2>

        <table>
            <tr>
                <th>Tên</th>
                <th>Giá</th>
            </tr>

            <% if (cart != null) {
                    for (Product p : cart) {
                        total += p.getPrice();
            %>
            <tr>
                <td><%=p.getName()%></td>
                <td><%=p.getPrice()%></td>
            </tr>
            <% }
                }%>

            <tr>
                <td><b>Tổng</b></td>
                <td><%=total%></td>
            </tr>
        </table>
    </div>

</div>

<jsp:include page="Layout/footer.jsp"/>