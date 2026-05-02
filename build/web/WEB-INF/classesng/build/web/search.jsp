<%-- 
    Document   : search
    Created on : Apr 19, 2026, 12:04:31 AM
    Author     : PC
--%>

<%@page import="java.util.List"%>
<%@page import="Model.Product"%>
<%@page import="Model.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link href="style.css" rel="stylesheet">

<!-- BANNER -->
<div class="banner">
    <img src="images/banner.png"/>
</div>

<!-- HEADER + MENU -->
<jsp:include page="Layout/header.jsp"/>
<jsp:include page="Layout/menu.jsp"/>

<div class="main">

    <!-- LEFT MENU -->
    <jsp:include page="Layout/left.jsp"/>

    <!-- CONTENT -->
    <div class="content">

        <!-- MENU TYPE -->
        <jsp:include page="Layout/ProductType.jsp"/>

        <%
            String keyword = request.getParameter("keyword");

            ProductDAO dao = new ProductDAO();
            List<Product> list = dao.searchByName(keyword);
        %>

        <h3>Kết quả tìm kiếm cho: "<%=keyword%>"</h3>

        <div class="grid">
            <% if (list != null && !list.isEmpty()) {
                    for (Product p : list) { %>

            <div class="product">

                <% if (p.getType() == 1) { %>
                <span class="label hot">HOT</span>
                <% } else if (p.getType() == 2) { %>
                <span class="label sale">SALE</span>
                <% } else if (p.getType() == 3) { %>
                <span class="label new">NEW</span>
                <% }%>

                <a href="detail.jsp?id=<%=p.getId()%>" class="product-link">
                    <img src="<%=p.getImage()%>">
                    <h4><%=p.getName()%></h4>
                </a>

                <% if (p.getDiscount_percent() != null && p.getDiscount_percent() > 0) {
                        long newPrice = p.getPrice() - (p.getPrice() * p.getDiscount_percent() / 100);
                %>

                <div class="product-price">
                    <div class="old-price">
                        <%=String.format("%,d", p.getPrice()).replace(",", ".")%> đ
                    </div>

                    <div>
                        <%=String.format("%,d", newPrice).replace(",", ".")%> đ
                    </div>

                    <div class="discount">-<%=p.getDiscount_percent()%>%</div>
                </div>

                <% } else {%>

                <div class="product-price">
                    <%=String.format("%,d", p.getPrice()).replace(",", ".")%> đ
                </div>

                <% }%>

                <div class="btn">      
                    <a href="detail.jsp?id=<%=p.getId()%>">Xem chi tiết</a>
                    <a href="Detail?id=<%=p.getId()%>" class="btn-cart-quick">🛒</a>
                </div>

            </div>

            <% }
            } else { %>

            <p style="text-align:center; width:100%;">Không tìm thấy sản phẩm</p>

            <% }%>
        </div>

    </div>
</div>

<!-- FOOTER -->
<jsp:include page="Layout/footer.jsp"/>

<!-- CHATBOX -->
<jsp:include page="Layout/Chatbox.jsp"/>