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
                <%
                    String error = request.getParameter("error");
                    if ("exist".equals(error)) {
                %>
                <p class="er">Tên sản phẩm đã tồn tại!</p>
                <% }%>

                <form action="UpdateProduct" method="post">

                    <input type="hidden" name="id" value="<%=p.getId()%>">

                    <div class="form-group">
                        <label>Tên sản phẩm:</label>
                        <input type="text" name="name" value="<%=p.getName()%>" required>
                    </div>

                    <div class="form-group">
                        <label>Giá (VNĐ):</label>
                        <input type="text" name="price" value="<%= String.format("%,d", p.getPrice()).replace(",", ".") %>" required>
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
                            <option value="tulanh" <%= p.getCategory().equals("tulanh") ? "selected" : "" %>>Tủ lạnh</option>
                            <option value="maygiat" <%= p.getCategory().equals("maygiat") ? "selected" : "" %>>Máy giặt</option>
                            <option value="tivi" <%= p.getCategory().equals("tivi") ? "selected" : "" %>>Tivi</option>
                            <option value="dieuhoa" <%= p.getCategory().equals("dieuhoa") ? "selected" : "" %>>Điều hòa</option>
                            <option value="noicomdien" <%= p.getCategory().equals("noicomdien") ? "selected" : "" %>>Nồi cơm điện</option>
                            <option value="quat" <%= p.getCategory().equals("quat") ? "selected" : "" %>>Quạt</option>
                            <option value="maylocnuoc" <%= p.getCategory().equals("maylocnuoc") ? "selected" : "" %>>Máy lọc nước</option>
                            <option value="noi" <%= p.getCategory().equals("noi") ? "selected" : "" %>>Nồi</option>
                        </select>
                    </div>

                    <!-- TYPE -->
                    <div class="form-group">
                        <label>Loại sản phẩm:</label>
                        <select name="type" required>
                            <option value="1" <%=p.getType() == 1 ? "selected" : ""%>>🔥 Hot</option>
                            <option value="2" <%=p.getType() == 2 ? "selected" : ""%>>💥 Sale</option>
                            <option value="3" <%=p.getType() == 3 ? "selected" : ""%>>🆕 New</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Giảm giá (%):</label>
                        <input type="number" id="discount" name="discount_percent"
                               value="<%=p.getDiscount_percent() == null ? 0 : p.getDiscount_percent()%>">
                    </div>

                    <div style="display:flex; gap:10px;">
                        <button class="btn">Cập nhật</button>
                        <a href="productManager.jsp" class="btn">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function toggleDiscount() {
                var type = document.querySelector("select[name='type']").value;
                var discount = document.getElementById("discount");

                if (type === "2") {
                    discount.disabled = false;
                } else {
                    discount.value = 0;
                    discount.disabled = true;
                }
            }

            // chạy khi load trang
            window.onload = toggleDiscount;

            // chạy khi đổi type
            document.querySelector("select[name='type']").addEventListener("change", toggleDiscount);
        </script>

        <!-- FOOTER -->
        <jsp:include page="Layout/footer.jsp"/>

        <!-- CHATBOX -->
        <jsp:include page="Layout/Chatbox.jsp"/>

    </body>
</html>
