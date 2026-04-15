<%-- 
    Document   : index
    Created on : Apr 6, 2026, 8:06:46 PM
    Author     : PC
--%>

<%@page import="java.util.List"%>
<%@page import="Model.ProductDAO"%>
<%@page import="Model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <div class="content">

                <%
                    String category = request.getParameter("category");

                    ProductDAO dao = new ProductDAO();
                    List<Product> list;

                    if (category == null || category.trim().equals("")) {
                        list = dao.getAll();
                    } else {
                        list = dao.getByCategory(category);
                    }
                %>

                <div class="special-titles">
                    <h2 class="active">Sản phẩm nổi bật</h2>
                    <h2>Sản phẩm giảm giá</h2>
                    <h2>Sản phẩm mới</h2>
                </div>

                <h3>
                    <%
                        String displayName;

                        if (category == null || category.equals("")) {
                            displayName = "Tất cả sản phẩm";
                        } else {
                            displayName = "Danh mục ";
                            switch (category) {
                                case "tulanh":
                                    displayName += "Tủ lạnh";
                                    break;
                                case "maygiat":
                                    displayName += "Máy giặt";
                                    break;
                                case "tivi":
                                    displayName += "Tivi";
                                    break;
                                case "dieuhoa":
                                    displayName += "Điều hòa";
                                    break;
                                default:
                                    displayName += category.toUpperCase();
                            }
                        }
                    %>

                    <%= displayName%>
                </h3>

                <!-- HIỂN THỊ SẢN PHẨM -->
                <div class="grid">
                    <% for (Product p : list) {%>
                    <div class="product">
                        <a href="detail.jsp?id=<%=p.getId()%>" class="product-link">
                            <img src="<%=p.getImage()%>">
                            <h4><%=p.getName()%></h4>
                        </a>

                        <p class="price" style="color: red; font-weight: bold;">
                            <%= String.format("%,d VNĐ", p.getPrice()).replace(",", ".")%>
                        </p>

                        <div class="btn">      
                            <a href="detail.jsp?id=<%=p.getId()%>">Xem chi tiết</a>    
                            <a href="Detail?id=<%=p.getId()%>" class="btn-cart-quick" title="Thêm vào giỏ hàng">
                                🛒
                            </a>
                        </div>
                    </div>
                    <% } %>
                </div>

            </div>
        </div>

        <!-- FOOTER -->
        <jsp:include page="Layout/footer.jsp"/>

        <!-- XỬ LÝ THÔNG BÁO + MODAL -->
        <%
            String msg = request.getParameter("msg");
            String reg_error = request.getParameter("reg_error");
        %>

        <script>
            window.onload = function () {

            <% if ("success".equals(msg)) { %>
                alert("Đăng nhập thành công!");
            <% } else if ("fail".equals(msg)) { %>
                alert("Đăng nhập thất bại!");
                openLogin();
            <% } %>

                // REGISTER
            <% if ("register_success".equals(msg)) { %>
                alert("Đăng ký thành công!");
                openLogin();
            <% } %>

                // VALIDATE REGISTER
            <% if ("empty".equals(reg_error)) { %>
                alert("Không được để trống!");
                openRegister();
            <% } else if ("pass".equals(reg_error)) { %>
                alert("Mật khẩu không khớp!");
                openRegister();
            <% } else if ("email".equals(reg_error)) { %>
                alert("Email không hợp lệ!");
                openRegister();
            <% } %>

                // CONTACT
            <% if ("contact_fail".equals(msg)) { %>
                alert("Vui lòng nhập đầy đủ!");
                openContact();
            <% } else if ("contact_success".equals(msg)) { %>
                alert("Gửi liên hệ thành công!");
            <% }%>
            };

            function openLogin() {
                document.getElementById("loginModal").style.display = "block";
            }

            function openRegister() {
                document.getElementById("registerModal").style.display = "block";
            }
            function openContact() {
                document.getElementById("contactModal").style.display = "block";
            }

            function closeContact() {
                document.getElementById("contactModal").style.display = "none";
            }
            function closeModal() {
                document.getElementById("loginModal").style.display = "none";
                document.getElementById("registerModal").style.display = "none";
            }

            window.onclick = function (event) {
                let login = document.getElementById("loginModal");
                let register = document.getElementById("registerModal");

                if (event.target === login)
                    login.style.display = "none";
                if (event.target === register)
                    register.style.display = "none";
            };
        </script>
        <%
            String cont_error = request.getParameter("cont_error");
            if ("contact_email".equals(cont_error)) {
        %>
        <script>
            alert("Email không hợp lệ!");
            openContact();
        </script>
        <%
        } else if ("contact_empty".equals(cont_error)) {
        %>
        <script>
            alert("Vui lòng nhập đầy đủ!");
            openContact();
        </script>
        <%
            }
        %>
        <script>


    </body>
