<%-- 
    Document   : contact
    Created on : Apr 6, 2026, 8:07:24 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="style.css" rel="stylesheet" type="text/css"/>


<jsp:include page="Layout/header.jsp"/>
<jsp:include page="Layout/menu.jsp"/>


<div class="main">

    <jsp:include page="Layout/left.jsp"/>

    <div class="content">
        <form>
            Tên: <input><br>
            Email: <input><br>
            Nội dung: <textarea></textarea><br>
            <button>Gửi</button>
        </form>
    </div>

</div>

<jsp:include page="Layout/footer.jsp"/>