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

    if (idStr != null && !idStr.trim().isEmpty()) {
        ProductDAO dao = new ProductDAO();
        p = dao.getById(Integer.parseInt(idStr));
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= (p != null) ? p.getName() : "Chi tiết"%></title>
        <link href="style.css" rel="stylesheet">
    </head>
    <body>
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

            <div class="content">
                <!-- MENU PRODUCT TYPE -->
                <jsp:include page="Layout/ProductType.jsp"/>
                <% if (p != null) {%>
                <div class="product-detail-container">
                    <div class="content-detail-wrapper" style="text-align: left; padding: 20px;">

                        <h1 class="product-title"><%= p.getName()%></h1>

                       <%-- 1. KHỐI HIỂN THỊ ẢNH (Có nhãn dính góc) --%>
                        <%-- Chúng ta bọc ảnh vào một div có position: relative --%>
                        <div class="main-product-image-container" style="position: relative; display: inline-block; margin-bottom: 20px; border: 1px solid #eaeaea; border-radius: 8px; overflow: hidden; background: #fff;">
        
                           <%-- Đặt nhãn dựa trên type, sử dụng class chuyên biệt .label-on-image --%>
                           <% if (p.getType() == 1) { %>
                              <div class="label-on-image hot">🔥 HOT</div>
                           <% } else if (p.getType() == 2) { %>
                              <div class="label-on-image sale">💥 SALE</div>
                           <% } else if (p.getType() == 3) { %>
                           <div class="label-on-image new">🆕 NEW</div>
                           <% } %>
                            <img src="<%= p.getImage()%>" alt="<%= p.getName()%>" style="display: block; max-width: 100%; height: auto;">
                        </div>

                        <div class="price-action-group">
                            <%-- HIỂN THỊ GIÁ KIỂU "VOUCHER" (MÀU ĐỎ RỰC) --%>
                                <div class="voucher-price-container" style="margin-bottom: 20px;">
                                <% if (p.getType() == 2 && p.getDiscount_percent() != null && p.getDiscount_percent() > 0) { %>
                
                            <%-- Giá gốc gạch ngang --%>
                            <p class="old-price-label" style="color: #999; text-decoration: line-through; font-size: 16px; margin: 0;">
                                <%= String.format("%,d VNĐ", p.getPrice()).replace(",", ".") %>
                            </p>
                
                            <%-- Giá sau giảm, màu đỏ rực kiểu Voucher --%>
                            <p class="final-voucher-price" style="color: #ee4d2d; font-size: 32px; font-weight: bold; margin: 5px 0; display: flex; align-items: baseline; gap: 5px;">
                            <%= String.format("%,.0f đ", p.getFinalPrice()).replace(",", ".") %> 
                    
                            <%-- Tag phần trăm giảm giá kiểu Voucher --%>
                                <span class="discount-percent-tag" style="background-color: #fbebed; color: #ee4d2d; border: 1px solid #ee4d2d; font-size: 14px; padding: 2px 8px; border-radius: 4px; font-weight: 600;">
                                    -<%= p.getDiscount_percent() %>%
                                </span>
                                <span class="voucher-text" style="color: #ee4d2d; font-size: 16px; font-weight: normal; margin-left: 5px;">
                                    Giá Sau Voucher
                                </span>
                            </p>
                
                                <% } else { %>
                                <%-- Nếu không giảm giá, hiện giá thường màu đỏ --%>
                                <p class="product-price" style="color: #ee4d2d; font-size: 30px; font-weight: bold; margin: 10px 0;">
                                     <%= String.format("%,.0f đ", p.getFinalPrice()).replace(",", ".") %> 
                                 </p>
                                <% } %>
                                </div>
                            <div class="detail-actions">
                                <button class="btn-buy-now">MUA NGAY</button>
                                <a href="Detail?id=<%= p.getId()%>" class="btn-add-cart" 
                                   style="text-decoration: none; display: inline-block;">
                                    THÊM GIỎ HÀNG
                                </a>
                            </div>
                        </div>

                        <div class="detail-description-section">
                            <h2 class="section-title">Mô tả chi tiết sản phẩm</h2>
                            <div class="description-content" style="white-space: pre-line;">
                                <%= p.getDescription()%>
                            </div>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div style="text-align: center; padding: 100px;">
                    <h2>Sản phẩm không tồn tại!</h2>
                    <a href="index.jsp">Quay lại trang chủ</a>
                </div>
                <% }%>
            </div>
        </div>
        <jsp:include page="Layout/footer.jsp"/>
        <jsp:include page="Layout/Chatbox.jsp"/>
</body>
</html>