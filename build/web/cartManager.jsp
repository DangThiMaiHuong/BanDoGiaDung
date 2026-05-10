<%-- 
    Document   : cartManager
    Created on : May 9, 2026, 3:36:04 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="Model.Product"%>
<%@page import="Model.ProductDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Giỏ hàng</title>
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
            <div class="content admin-page">

                <h1 style="text-align: center">SẢN PHẨM ĐƯỢC THÊM NHIỀU NHẤT</h1>
                <table style="margin-bottom: 50px;">
                    <thead>
                        <tr>
                            <th>ProductName</th>
                            <th>Price</th>
                            <th>Image</th>
                            <th>Type</th>
                            <th>Discount</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Giả sử hàm này trả về danh sách kèm theo cột tổng số lượng
                            List<Product> topProducts = new ProductDAO().getTopMostAddedProducts();
                            if (topProducts != null) {
                                for (Product p : topProducts) {
                        %>
                        <tr>
                            <td><%=p.getName()%></td>
                            <td>
                                <% if (p.getType() == 2 && p.getDiscount_percent() != null && p.getDiscount_percent() > 0) {%>
                                <del style="color: gray; font-size: 0.9em;"><%= String.format("%,d", p.getPrice()).replace(",", ".")%> VNĐ</del><br/>
                                <b style="color: red;"><%= String.format("%,d", (long) p.getFinalPrice()).replace(",", ".")%> VNĐ</b>
                                <% } else {%>
                                <%= String.format("%,d", p.getPrice()).replace(",", ".")%> VNĐ
                                <% }%>
                            </td>
                            <td><img src="<%=p.getImage()%>" width="50"/></td>
                            <td><%= (p.getType() == 1) ? "🔥 Hot" : (p.getType() == 2 ? "💥 Sale" : "🆕 New")%></td>
                            <td><%=p.getDiscount_percent()%>%</td>
                            <td style="font-weight: bold; color: red;"><%=p.getTotalQty()%></td> 
                        </tr>
                        <%      }
                            } %>
                    </tbody>
                </table>

                <h1 style="text-align: center">CHI TIẾT GIỎ HÀNG NGƯỜI DÙNG</h1>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="background-color: #f2f2f2;">
                            <th>Username</th>
                            <th>ProductName</th>
                            <th>Image</th>
                            <th>Price</th>
                            <th>Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Gọi hàm lấy dữ liệu từ DAO
                            List<java.util.Map<String, Object>> allCarts = new ProductDAO().getAllCartItems();

                            if (allCarts != null && !allCarts.isEmpty()) {
                                for (java.util.Map<String, Object> item : allCarts) {
                                    try {
                                        // CÁCH LẤY DỮ LIỆU AN TOÀN: Chuyển về String rồi mới Parse
                                        long originalPrice = Long.parseLong(item.get("price").toString());
                                        int discount = Integer.parseInt(item.get("discount").toString());
                                        int type = Integer.parseInt(item.get("type").toString());
                                        int quantity = Integer.parseInt(item.get("quantity").toString());

                                        long finalPrice = originalPrice;
                                        if (type == 2 && discount > 0) {
                                            finalPrice = originalPrice * (100 - discount) / 100;
                                        }
                        %>
                        <tr>
                            <td style="padding: 10px;"><%= item.get("username")%></td>
                            <td style="padding: 10px;"><%= item.get("productName")%></td>
                            <td style="text-align: center; padding: 5px;">
                                <img src="<%= item.get("image")%>" width="50" style="border-radius: 5px;"/>
                            </td>
                            <td style="color: #2c3e50; font-weight: 500; padding: 10px;">
                                <%= String.format("%,d", finalPrice).replace(",", ".")%> VNĐ
                                <% if (type == 2 && discount > 0) {%>
                                <br><small style="color: red;">(<del><%= String.format("%,d", originalPrice).replace(",", ".")%> VNĐ</del>)</small>
                                <% }%>
                            </td>
                            <td style="text-align: center;"><%= quantity%></td>
                        </tr>
                        <%
                                } catch (Exception e) {
                                    // Nếu một dòng bị lỗi định dạng, vẫn tiếp tục các dòng sau
                                    out.println("");
                                }
                            } // End for
                        } else {
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 20px;">
                                <b>Hiện chưa có người dùng nào thêm sản phẩm vào giỏ hàng.</b>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>
        <jsp:include page="Layout/footer.jsp"/>
        <jsp:include page="Layout/Chatbox.jsp"/>
    </body>
</html>
