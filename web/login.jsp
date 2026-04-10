<%-- 
    Document   : login
    Created on : Apr 6, 2026, 8:06:57 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="Layout/header.jsp"/>
<jsp:include page="Layout/menu.jsp"/>
<link href="style.css" rel="stylesheet" type="text/css"/>
<div class="main">

    <jsp:include page="Layout/left.jsp"/>

    <div class="content">
        <form action="Login" method="post">
            Email: <input name="email"><br>
            Pass : <input type="password" name="password"><br>
            <button>Login</button>
        </form>
    </div>

</div>

<jsp:include page="Layout/footer.jsp"/>
