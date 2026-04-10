<%-- 
    Document   : register
    Created on : Apr 6, 2026, 8:07:05 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>



<jsp:include page="Layout/header.jsp"/>
<jsp:include page="Layout/menu.jsp"/>
<link href="style.css" rel="stylesheet" type="text/css"/>
<div class="main">

    <jsp:include page="Layout/left.jsp"/>

    <div class="content">

        <h2>Đăng ký</h2>

        <!-- HIỂN THỊ LỖI -->
        <p style="color:red;">
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : ""%>
        </p>

        <form action="Register" method="post">
            Tên: <input name="username"><br>
            Email: <input name="email"><br>
            SĐT: <input name="phone"><br>
            Địa chỉ: <input name="address"><br>
            Mật khẩu: <input type="password" name="password"><br>
            Nhập lại: <input type="password" name="repassword"><br>

            <button>Đăng ký</button>
        </form>

    </div>

</div>

<jsp:include page="Layout/footer.jsp"/>