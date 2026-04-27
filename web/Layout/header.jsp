<%-- 
    Document   : header
    Created on : Apr 6, 2026, 8:37:47 PM
    Author     : PC
--%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style.css" rel="stylesheet">
<div class="header">
    <div class="logo">⚡ Điện Máy Mini</div>

    <div class="search">
        <span class="search-icon">🔍</span>
        <input type="text" id="searchBox" placeholder=" Tìm kiếm sản phẩm...">
        <div id="suggestBox"></div>
    </div>

    <%
        Model.User user = (Model.User) session.getAttribute("user");
    %>

    <div class="user">
        <% if (user == null) { %>

        👤 
        <a href="#" onclick="openLogin()">Đăng nhập</a> 
        👤
        <a href="#" onclick="openRegister()">Đăng ký</a>

        <% } else {%>

        👤 Chào, <b><%= user.getUsername()%></b> |
        <a href="Logout">Đăng xuất</a>

        <% }%>

        <%
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            int totalItems = 0;
            if (cart != null) {
                // Cộng dồn tất cả số lượng của từng món hàng
                for (int qty : cart.values()) {
                    totalItems += qty;
                }
            }
        %>
        <a href="cart.jsp">
            🛒 Giỏ hàng (<span style="color: red; font-weight: bold;"><%= totalItems%></span>)
        </a>
        <a href="#"onclick="openContact()">Liên hệ</a>
    </div>
    <!-- LOGIN MODAL -->
    <div id="loginModal" class="modal">
        <div class="modal-content">
            <span onclick="closeModal()" class="close">&times;</span>

            <h2>Đăng nhập</h2>
            <%
                String msg = request.getParameter("msg");
            %>

            <form action="Login" method="post">
                <div class="form-group">
                    <label>Username:</label>
                    <input name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : ""%>" required>
                </div>

                <div class="form-group">
                    <label>Password:</label>
                    <input type="password" name="password" required>
                </div>
                <!-- HIỂN THỊ LỖI -->
                <% if ("fail".equals(msg)) { %>
                <p style="color:red; text-align:center;">
                    Tài khoản không hợp lệ
                </p>
                <% }%>
                <button  class="btn">Đăng nhập</button>
                <div style="text-align:center; margin-top:10px;">
                    Chưa có tài khoản? 
                    <a href="#" onclick="switchToRegister()">Đăng ký</a>
                </div>
            </form>
        </div>
    </div>

    <!-- REGISTER MODAL -->
    <div id="registerModal" class="modal">
        <div class="modal-content">
            <span onclick="closeModal()" class="close">&times;</span>

            <h2>Đăng ký</h2>

            <form action="Register" method="post">

                <div class="form-group">
                    <label>Tên:</label>
                    <input name="username" required>
                </div>

                <div class="form-group">
                    <label>Email:</label>
                    <input name="email" required>
                </div>

                <div class="form-group">
                    <label>SĐT:</label>
                    <input name="phone" required>
                </div>

                <div class="form-group">
                    <label>Địa chỉ:</label>
                    <input name="address" required>
                </div>

                <div class="form-group">
                    <label>Mật khẩu:</label>
                    <input type="password" name="password" required>
                </div>

                <div class="form-group">
                    <label>Nhập lại:</label>
                    <input type="password" name="repassword" required>
                </div>

                <button class="btn">Đăng ký</button>

            </form>
        </div>
    </div>
    <!-- CONTACT MODAL -->
    <div id="contactModal" class="modal">
        <div class="modal-content">

            <span class="close" onclick="closeContact()">&times;</span>

            <h2>Liên hệ</h2>

            <form action="Contact" method="post">
                <div class="form-group">
                    <label>Tên:</label>
                    <input name="name" 
                           value="<%= (user != null ? user.getUsername() : "")%>"
                           <%= (user != null ? "readonly" : "")%> required>
                </div>

                <div class="form-group">
                    <label>Email:</label>
                    <input name="email"
                           value="<%= (user != null ? user.getEmail() : "")%>"
                           <%= (user != null ? "readonly" : "")%> required>
                </div>

                <div class="form-group">
                    <label>Nội dung:</label>
                    <textarea name="message" style="width:95%; height:80px;" required></textarea>
                </div>

                <button class="btn">Gửi</button>
            </form>

        </div>
    </div>
</div>
<!-- XỬ LÝ THÔNG BÁO + MODAL -->
<%
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
<!-- XỬ LÝ TÌM KIẾM -->
<script>
    document.addEventListener("DOMContentLoaded", function () {

        const input = document.getElementById("searchBox");
        const box = document.getElementById("suggestBox");

        input.addEventListener("keyup", function () {
            let keyword = input.value;

            if (keyword.length === 0) {
                box.style.display = "none";
                return;
            }

            fetch("<%=request.getContextPath()%>/Search?keyword=" + keyword)
                    .then(res => res.json())
                    .then(data => {

                        box.innerHTML = "<b>Có phải bạn muốn tìm</b><hr>";

                        data.forEach(p => {

                            let label = "";
                            let priceHTML = "";

                            // ICON
                            if (p.type === 1) {
                                label = '<span class="label hot">HOT</span>';
                            } else if (p.type === 2) {
                                label = '<span class="label new">NEW</span>';
                            } else if (p.type === 3) {
                                label = '<span class="label sale">SALE</span>';
                            }

                            // GIÁ
                            if (p.discount > 0) {
                                let newPrice = p.price - (p.price * p.discount / 100);

                                priceHTML =
                                        '<div class="suggest-price">'
                                        + newPrice.toLocaleString() + ' đ '
                                        + '<span class="old-price">' + p.price.toLocaleString() + ' đ</span>'
                                        + '<span class="discount">-' + p.discount + '%</span>'
                                        + '</div>';
                            } else {
                                priceHTML =
                                        '<div class="suggest-price">'
                                        + p.price.toLocaleString() + ' đ'
                                        + '</div>';
                            }

                            // HTML
                            box.innerHTML +=
                                    '<div class="suggest-item" onclick="goDetail(' + p.id + ')">'
                                    + '<img src="' + p.image + '" style="width:50px;height:50px;">'
                                    + '<div>'
                                    + '<div>' + p.name + '</div>'
                                    + priceHTML
                                    + '</div>'
                                    + '</div>';
                        });

                        box.style.display = "block";
                    });
        });
        // ENTER TÌM KIẾM
        input.addEventListener("keypress", function (e) {
            if (e.key === "Enter") {
                window.location = "search.jsp?keyword=" + input.value;
            }
        });

    });

    function goDetail(id) {
        window.location = "detail.jsp?id=" + id;
    }
</script>
