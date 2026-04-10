<%-- 
    Document   : header
    Created on : Apr 6, 2026, 8:37:47 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style.css" rel="stylesheet">
<div class="header">
    <div class="logo">⚡ Điện Máy Mini</div>

    <div class="search">
        <input placeholder=" 🔍  Tìm kiếm sản phẩm.....">
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
        
       <span class="cart">
        🛒 <a href="#" onclick="shoppingcart()">Giỏ hàng</a>
    </span>
        
    </div>
    <!-- LOGIN MODAL -->
    <div id="loginModal" class="modal">
        <div class="modal-content">
            <span onclick="closeModal()" class="close">&times;</span>

            <h2>Đăng nhập</h2>

            <form action="Login" method="post">
                <div class="form-group">
                    <label>Username:</label>
                    <input name="username">
                </div>
                
                <div class="form-group">
                    <label>Password:</label>
                    <input type="password" name="password">
                </div>
                
                <button  class="btn">Đăng nhập</button>
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
                    <input name="username">
                </div>

                <div class="form-group">
                    <label>Email:</label>
                    <input name="email">
                </div>

                <div class="form-group">
                    <label>SĐT:</label>
                    <input name="phone">
                </div>

                <div class="form-group">
                    <label>Địa chỉ:</label>
                    <input name="address">
                </div>

                <div class="form-group">
                    <label>Mật khẩu:</label>
                    <input type="password" name="password">
                </div>

                <div class="form-group">
                    <label>Nhập lại:</label>
                    <input type="password" name="repassword">
                </div>

                <button class="btn">Đăng ký</button>

            </form>
        </div>
    </div>
</div>