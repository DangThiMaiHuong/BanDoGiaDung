<%-- 
    Document   : productManager
    Created on : Apr 29, 2026, 3:50:05 PM
    Author     : PC
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.ProductDAO"%>
<%@page import="Model.Product"%>
<link href="<%=request.getContextPath()%>/style.css" rel="stylesheet">

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Điện Máy Mini</title>
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

            <!-- CONTENT -->
            <div class="content admin-page">
                <!-- MENU PRODUCT TYPE -->
                <jsp:include page="Layout/ProductType.jsp"/>

                <h1 style="text-align: center">QUẢN LÝ SẢN PHẨM</h1>
                <a href="addProduct.jsp" class="btn-add">Thêm sản phẩm</a>
                <table>
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Image</th>
                            <th>Category</th>
                            <th>Type</th>
                            <th>Discount percent</th>
                            <th>Modified</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Product> kList = new ProductDAO().getAll();
                            if (kList != null) {
                                for (Product p : kList) {
                        %>
                        <tr>
                            <td><%=p.getId()%></td>
                            <td><%=p.getName()%></td>
                            <td><%= String.format("%,d", p.getPrice())%> đ</td>
                            <td><image src="<%=p.getImage()%>"/></td>
                            <td><%=p.getCategory()%></td>
                            <td>
                                <% if (p.getType() == 1) { %>
                                🔥 Hot
                                <% } else if (p.getType() == 2) { %>
                                💥 Sale
                                <% } else { %>
                                🆕 New
                                <% }%>
                            </td>
                            <td><%=p.getDiscount_percent()%></td>
                            <td><a class="action-btn btn-update" href="updateProduct.jsp?id=<%=p.getId()%>">Sửa</a>
                                <a class="action-btn btn-delete" href="deleteProduct.jsp?id=<%=p.getId()%>">Xóa</a>
                            </td>
                        </tr>
                        <%      }
                            }
                        %>  
                    </tbody>
                </table>
            </div>
            </div>
            <!-- FOOTER -->
            <jsp:include page="Layout/footer.jsp"/>

            <!-- CHATBOX -->
            <jsp:include page="Layout/Chatbox.jsp"/>
    </body>
</html>
