<%-- 
    Document   : deleteProduct
    Created on : Apr 29, 2026, 3:49:52 PM
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
                <!-- MENU PRODUCT TYPE -->
                <jsp:include page="Layout/ProductType.jsp"/>

                <form action="DeleteProduct" method="post" class="delete-form">

                    <input type="hidden" name="id" value="<%=p.getId()%>">

                    <div class="form-group">
                        <label>Tên sản phẩm:</label>
                        <input type="text" value="<%=p.getName()%>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Giá:</label>
                        <input type="text" value="<%=p.getPrice()%>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Ảnh (URL):</label>
                        <div>
                            <div class="img-preview">
                                <img src="<%=p.getImage()%>"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Mô tả:</label>
                        <textarea readonly><%=p.getDescription()%></textarea>
                    </div>

                    <div class="form-group">
                        <label>Danh mục:</label>
                        <input type="text" value="<%=p.getCategory()%>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Loại sản phẩm:</label>
                        <input type="text" value="
                               <%
                                   if (p.getType() == 1)
                                       out.print("🔥 Hot");
                                   else if (p.getType() == 2)
                                       out.print("💥 Sale");
                                   else
                                       out.print("🆕 New");
                               %>
                               " readonly>
                    </div>

                    <div class="form-group">
                        <label>Giảm giá (%):</label>
                        <input type="text" value="<%=p.getDiscount_percent()%>" readonly>
                    </div>
                    <p style="color:red; font-weight:bold;">
                        Bạn có chắc muốn xóa sản phẩm này?
                    </p>

                    <button class="btn" style="background:red;">XÓA</button>
                </form>

            </div>
        </div>
        <!-- FOOTER -->
        <jsp:include page="Layout/footer.jsp"/>

        <!-- CHATBOX -->
        <jsp:include page="Layout/Chatbox.jsp"/>
    </body>
</html>
