<%-- 
    Document   : cart
    Created on : Apr 6, 2026, 8:07:19 PM
    Author     : PC
<%@page import="java.util.List"%>
<%@page import="Model.Product"%>
<%@page import="Model.Product"%>
--%>

<%@page import="java.util.Map"%>
<%@page import="Model.Product"%>
<%@page import="Model.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="style.css" rel="stylesheet" type="text/css"/>
<div class="banner">
    <img src="images/banner.png"/>
</div>
<jsp:include page="Layout/header.jsp"/>
<jsp:include page="Layout/menu.jsp"/>
<!-- BANNER -->

<div class="main">

    <jsp:include page="Layout/left.jsp"/>
    <div class="content">
        <div class="cart-wrapper">
            <h2>🛒 Chi tiết giỏ hàng</h2>

            <%
                Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
                if (cart == null || cart.isEmpty()) {
            %>
            <div style="text-align: center; padding: 50px;">
                <p>Giỏ hàng đang trống.</p>
                <a href="index.jsp">Quay lại mua sắm</a>
            </div>
            <%
            } else {
                ProductDAO dao = new ProductDAO();
                double totalMoney = 0;
                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    Product p = dao.getById(entry.getKey());
                    if (p != null) {
                        int qty = entry.getValue();
                        totalMoney += p.getPrice() * qty;
            %>
            <div class="cart-item">
                <input type="checkbox" checked style="accent-color: #ff4d4f; transform: scale(1.2);">

                <a href="detail.jsp?id=<%= p.getId()%>">
                    <img src="<%= p.getImage()%>" class="cart-product-img">
                </a>

                <div class="cart-info">
                    <div class="product-name"><%= p.getName()%></div>
                    <div class="cart-price" style="color: #ff4d4f; font-weight: bold;">
                        <%= String.format("%,d", p.getPrice())%> đ
                    </div>
                </div>

                <div style="text-align: right; min-width: 90px;">
                    <a href="RemoveCart?id=<%= p.getId()%>" 
                       style="text-decoration:none; font-size: 20px; color: black;" 
                       onmouseover="this.style.color = 'red'" 
                       onmouseout="this.style.color = '#ccc'">✕</a>

                    <div class="quantity-control">
                        <p>Số lượng:</p>
                        <a href="Detail?id=<%= p.getId()%>&action=decrease" class="btn-qty">-</a>    
                        <input type="number" value="<%= qty%>" class="qty-input" min="1"
                               onchange="window.location.href = 'Detail?id=<%= p.getId()%>&action=update&newQty=' + this.value">
                        <a href="Detail?id=<%= p.getId()%>&action=increase" class="btn-qty">+</a>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>

            <div class="cart-footer">
                <p>Tổng thanh toán: <span class="total-price"><%= String.format("%,d", (long) totalMoney)%> đ</span></p>
                <button class="btn-pay">THANH TOÁN</button>
            </div>
            <% }%>
        </div>
    </div>
</div>


<jsp:include page="Layout/footer.jsp"/>