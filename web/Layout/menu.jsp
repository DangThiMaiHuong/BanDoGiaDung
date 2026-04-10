<%-- 
    Document   : menu
    Created on : Apr 6, 2026, 8:37:53 PM
    Author     : PC
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String c = request.getParameter("category");
%>

<div class="menu">
    <a href="index.jsp">Trang chủ</a>

    <a class="<%= "tulanh".equals(c) ? "active" : ""%>"
       href="index.jsp?category=tulanh">Tủ lạnh</a>

    <a class="<%= "maygiat".equals(c) ? "active" : ""%>"
       href="index.jsp?category=maygiat">Máy giặt</a>

    <a class="<%= "tivi".equals(c) ? "active" : ""%>"
       href="index.jsp?category=tivi">Tivi</a>

    <a class="<%= "dieuhoa".equals(c) ? "active" : ""%>"
       href="index.jsp?category=dieuhoa">Điều hòa</a>
    <a href="#" onclick="openContact()">Liên hệ</a>
    <!-- CONTACT MODAL -->
    <%
        User u = (User) session.getAttribute("user");
    %>
    <div id="contactModal" class="modal">
        <div class="modal-content">

            <span class="close" onclick="closeContact()">&times;</span>

            <h2>Liên hệ</h2>

            <form action="ContactServlet" method="post">
                <div class="form-group">
                    <label>Tên:</label>
                    <input name="name"
                           value="<%= (u != null ? u.getUsername() : "")%>"
                           <%= (u != null ? "readonly" : "")%>>
                </div>

                <div class="form-group">
                    <label>Email:</label>
                    <input name="email"
                           value="<%= (u != null ? u.getEmail() : "")%>"
                           <%= (u != null ? "readonly" : "")%>>
                </div>

                <div class="form-group">
                    <label>Nội dung:</label>
                    <textarea name="message" style="width:95%; height:80px;"></textarea>
                </div>

                <button class="btn">Gửi</button>
            </form>

        </div>
    </div>
</div>