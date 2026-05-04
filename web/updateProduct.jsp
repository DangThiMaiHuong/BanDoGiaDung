<%-- 
    Document   : updateProduct
    Created on : Apr 29, 2026, 3:49:43 PM
    Author     : PC
--%>

<%@page import="Model.Product"%>
<%@page import="Model.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ProductDAO dao = new ProductDAO();
    Product p = dao.getById(id);
%>
<link href="<%=request.getContextPath()%>/style.css" rel="stylesheet">

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
                <jsp:include page="Layout/ProductType.jsp"/>

                <form action="UpdateProduct" method="post">

                    <input type="hidden" name="id" value="<%=p.getId()%>">

                    <div class="form-group">
                        <label>Tên sản phẩm:</label>
                        <input type="text" name="name" value="<%=p.getName()%>" required>
                    </div>

                    <div class="form-group">
                        <label>Giá:</label>
                        <input type="number" name="price" value="<%=p.getPrice()%>" required>
                    </div>

                    <div class="form-group">
                        <label>Ảnh (URL):</label>
                        <input type="text" name="image" value="<%=p.getImage()%>" required>
                    </div>

                    <div class="form-group">
                        <label>Mô tả:</label>
                        <textarea rows="5" name="description"><%=p.getDescription()%></textarea>
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
                        <input type="number" name="discount_percent"
                               value="<%=p.getDiscount_percent() == null ? 0 : p.getDiscount_percent()%>">
                    </div>

                    <button class="btn">Cập nhật</button>

                </form>
            </div>
        </div>

        <!-- FOOTER -->
        <jsp:include page="Layout/footer.jsp"/>

        <!-- CHATBOX -->
        <jsp:include page="Layout/Chatbox.jsp"/>

    </body>
</html>
