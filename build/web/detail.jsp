<%-- 
    Document   : detail
    Created on : Apr 10, 2026, 11:52:20 PM
    Author     : pc
--%>
<%@page import="Model.Product"%>
<%@page import="Model.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String idStr = request.getParameter("id");
    Product p = null;
    if (idStr != null) {
        ProductDAO dao = new ProductDAO();
        p = dao.getById(Integer.parseInt(idStr));
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= (p != null) ? p.getName() : "Chi tiết" %></title>
    <link href="style.css" rel="stylesheet">
</head>
<body>
    <!-- BANNER -->
        <div class="banner">
            <img src="images/banner.png"/>
        </div>
    <jsp:include page="Layout/header.jsp"/>
    <jsp:include page="Layout/menu.jsp"/>

    <div class="main">
        <jsp:include page="Layout/left.jsp"/>

        <div class="content">
    <% if (p != null) { %>
        <div class="product-detail-container">
            <div class="content-detail-wrapper" style="text-align: left; padding: 20px;">
                
                <h1 class="product-title"><%= p.getName() %></h1>

                <div class="small-center-image">
                    <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
                </div>

                <div class="price-action-group">
                    <p class="product-price">
                        <%= String.format("%,d VNĐ", p.getPrice()).replace(",", " ") %> 
                    </p>
                    <div class="detail-actions">
                        <button class="btn-buy-now">MUA NGAY</button>
                       <a href="Detail?id=<%= p.getId() %>" class="btn-add-cart" 
                            style="text-decoration: none; display: inline-block;">
                                THÊM GIỎ HÀNG
                         </a>
                    </div>
                </div>

                <div class="detail-description-section">
                    <h2 class="section-title">Mô tả chi tiết sản phẩm</h2>
                    <div class="description-content" style="white-space: pre-line;">
                        <%= p.getDescription() %>
                    </div>
                </div>
            </div>
        </div>
    <% } else { %>
        <div style="text-align: center; padding: 100px;">
            <h2>Sản phẩm không tồn tại!</h2>
            <a href="index.jsp">Quay lại trang chủ</a>
        </div>
    <% } %>
</div>
        </div> </div> <jsp:include page="Layout/footer.jsp"/>
</body>
</html>