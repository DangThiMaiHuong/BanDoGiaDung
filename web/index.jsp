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
                <div class="special-titles">

                    <h2>
                        <a href="Type?type=0">Tất cả sản phẩm</a>
                    </h2>

                    <h2 class="${activeType == 1 ? 'active' : ''}">
                        <a href="Type?type=1">Sản phẩm nổi bật</a>
                    </h2>

                    <h2 class="${activeType == 2 ? 'active' : ''}">
                        <a href="Type?type=2">Sản phẩm giảm giá</a>
                    </h2>

                    <h2 class="${activeType == 3 ? 'active' : ''}">
                        <a href="Type?type=3">Sản phẩm mới</a>
                    </h2>
                </div>
                <h3>
                    <%
                        String category = (String) request.getAttribute("category");

                        if (category == null) {
                            category = request.getParameter("category");
                        }

                        ProductDAO dao = new ProductDAO();
                        List<Product> list;

                        if (category == null || category.trim().equals("")) {
                            list = dao.getAll();
                        } else {
                            list = dao.getByCategory(category);
                        }
                    %>
                    <%
                        String displayName;

                        if (category == null || category.equals("")) {
                            displayName = "";
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
                                case "noicomdien":
                                    displayName += "Nồi cơm điện";
                                    break;
                                case "quat":
                                    displayName += "Quạt";
                                    break;
                                case "maylocnuoc":
                                    displayName += "Máy lọc nước";
                                    break;
                                case "noi":
                                    displayName += "Nồi";
                                    break;
                                default:
                                    displayName += category.toUpperCase();
                            }
                        }
                    %>

                    <%= displayName%>
                </h3>
                <%
                    String category1 = request.getParameter("category");

                    ProductDAO dao1 = new ProductDAO();
                    List<Product> list1;

                    if (category1 == null || category1.trim().equals("")) {
                        list1 = null;
                    } else {
                        list1 = dao1.getByCategory(category1);
                    }
                %>
                <!--HIỂN THỊ SẢN PHẨM THEO CATEGORY-->
                <div class="grid">
                    <%
                        if (list1 != null) {
                            for (Product p : list1) {%>
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
                    <% }
                        }%>
                </div>
                <%
                    String typeParam = request.getParameter("type");
                    int type;

                    if (typeParam == null || typeParam.isEmpty() || typeParam.equals("0")) {
                        type = 0; // tất cả
                    } else {
                        type = Integer.parseInt(typeParam);
                    }

                    ProductDAO daoType = new ProductDAO();
                    List<Product> listType;

                    if (type == 0) {
                        listType = daoType.getAll(); // TẤT CẢ
                    } else {
                        listType = daoType.getProductByType(type);
                    }
                %>

                <%
                    if (category1 == null || category1.trim().equals("")) { %>
                <div class="grid">
                    <%
                        for (Product p : listType) {
                    %>

                    <div class="product">

                        <% if (type == 0) { %>

                        <% if (p.getType() == 1) { %>
                        <div class="label hot">🔥 HOT</div>
                        <% } %>

                        <% if (p.getType() == 2) { %>
                        <div class="label sale">💥 SALE</div>
                        <% } %>

                        <% if (p.getType() == 3) { %>
                        <div class="label new">🆕 NEW</div>
                        <% } %>

                        <% } else { %>

                        <% if (p.getType() == 1) { %>
                        <div class="label hot">🔥 HOT</div>
                        <% } %>

                        <% if (p.getType() == 2) { %>
                        <div class="label sale">💥 SALE</div>
                        <% } %>

                        <% if (p.getType() == 3) { %>
                        <div class="label new">🆕 NEW</div>
                        <% } %>

                        <% }%>

                        <img src="<%=p.getImage()%>">
                        <h4><%=p.getName()%></h4>

                        <% if (p.getType() == 2 && p.getDiscount_percent() != null && p.getDiscount_percent() > 0) {%>

                        <p class="old-price">
                            <%= String.format("%,d VNĐ", p.getPrice()).replace(",", ".")%>
                        </p>

                        <p class="price">
                            <%= String.format("%,.0f VNĐ", p.getFinalPrice()).replace(",", ".")%>
                        </p>

                        <span class="discount">
                            -<%=p.getDiscount_percent()%>%
                        </span>

                        <% } else {%>

                        <p class="price">
                            <%= String.format("%,d VNĐ", p.getPrice()).replace(",", ".")%>
                        </p>

                        <% }%>
                        <div class="btn">
                            <a href="detail.jsp?id=<%=p.getId()%>">Xem chi tiết</a>

                            <a href="Detail?id=<%=p.getId()%>" class="btn-cart-quick" title="Thêm vào giỏ hàng">
                                🛒
                            </a>
                        </div>

                    </div>
                    <%
                        }
                    %>
                </div>
                <%}%>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <jsp:include page="Layout/footer.jsp"/>

    <!-- CHATBOX -->
    <jsp:include page="Layout/Chatbox.jsp"/>
    <!-- XỬ LÝ THÔNG BÁO + MODAL -->
    <%
        String msg = request.getParameter("msg");
        String reg_error = request.getParameter("reg_error");
    %>

    <script>
        window.onload = function () {

        <% if ("success".equals(msg)) { %>
            alert("Đăng nhập thành công!");
            //Xóa tham số msg khỏi URL mà không load lại trang
            if (window.history.replaceState) {
                const url = new URL(window.location);
                url.searchParams.delete('msg'); // Xóa riêng tham số msg
                window.history.replaceState({}, document.title, url.pathname + url.search);
            }
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
        function switchToRegister() {
            document.getElementById("loginModal").style.display = "none";
            document.getElementById("registerModal").style.display = "block";
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
</body>
</html>
