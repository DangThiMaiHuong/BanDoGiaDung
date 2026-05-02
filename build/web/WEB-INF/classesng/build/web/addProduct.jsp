<%-- 
    Document   : addProduct
    Created on : Apr 29, 2026, 3:49:32 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style.css" rel="stylesheet">
<%
    String error = request.getParameter("error");
%>
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
                <form action="AddProduct" method="post">

                    <div class="form-group">
                        <label>Tên sản phẩm:</label>
                        <input type="text" name="name" required>
                    </div>

                    <div class="form-group">
                        <label>Giá:</label>
                        <input type="number" name="price" required>
                    </div>

                    <div class="form-group">
                        <label>Ảnh (URL):</label>
                        <input type="text" name="image" required>
                    </div>

                    <div class="form-group">
                        <label>Mô tả:</label>
                        <textarea name="description" rows="5" style="width:24.5%;" required></textarea>
                    </div>

                    <!-- CATEGORY -->
                    <div class="form-group">
                        <label>Danh mục:</label>
                        <select name="category" required>
                            <option value="tulanh">Tủ lạnh</option>
                            <option value="maygiat">Máy giặt</option>
                            <option value="tivi">Tivi</option>
                            <option value="dieuhoa">Điều hòa</option>
                            <option value="noicomdien">Nồi cơm điện</option>
                            <option value="quat">Quạt</option>
                            <option value="maylocnuoc">Máy lọc nước</option>
                            <option value="noi">Nồi</option>
                        </select>
                    </div>

                    <!-- TYPE -->
                    <div class="form-group">
                        <label>Loại sản phẩm:</label>
                        <select name="type" required>
                            <option value="1">🔥 Hot</option>
                            <option value="2">💥 Sale</option>
                            <option value="3">🆕 New</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Giảm giá (%):</label>
                        <input type="number" name="discount_percent" min="0" max="100" value="0">
                    </div>
                    <% if ("exist".equals(error)) { %>
                    <p style="color:red; text-align:center;">
                        Sản phẩm đã tồn tại
                    </p>
                    <% }%>
                    <button class="btn">Thêm sản phẩm</button>

                </form>
            </div>
        </div>
        <!-- FOOTER -->
        <jsp:include page="Layout/footer.jsp"/>

        <!-- CHATBOX -->
        <jsp:include page="Layout/Chatbox.jsp"/>
    </body>
</html>