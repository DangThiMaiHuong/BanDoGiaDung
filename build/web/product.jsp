<%-- 
    Document   : product
    Created on : Apr 6, 2026, 8:07:12 PM
    Author     : PC
--%>

<%@page import="Model.ProductDAO"%>
<%@page import="Model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="style.css" rel="stylesheet" type="text/css"/>
<jsp:include page="Layout/header.jsp"/>
<jsp:include page="Layout/menu.jsp"/>

<div class="main">

    <jsp:include page="Layout/left.jsp"/>

    <div class="content">

        <%
            int id = Integer.parseInt(request.getParameter("id"));
            Product p = new ProductDAO().getById(id);
        %>

        <h2><%=p.getName()%></h2>
        <img src="images/<%=p.getImage()%>" width="300">
        <p class="price"><%=p.getPrice()%></p>
        <p><%=p.getDescription()%></p>

        <a href="Cart?id=<%=p.getId()%>">Thêm giỏ</a>

    </div>

</div>

<jsp:include page="Layout/footer.jsp"/>