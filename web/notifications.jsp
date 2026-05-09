<%-- 
    Document   : notifications
    Created on : May 9, 2026, 6:17:56 PM
    Author     : pc
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="Model.ContactDAO"%>
<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="style.css" rel="stylesheet" type="text/css"/>
<link href="notifications.css" rel="stylesheet" type="text/css"/>

<div class="banner">
    <img src="images/banner.png"/>
</div>

<jsp:include page="Layout/header.jsp"/>
<jsp:include page="Layout/menu.jsp"/>

<div class="main">
    <jsp:include page="Layout/left.jsp"/>

    <div class="content">
        <jsp:include page="Layout/ProductType.jsp"/>
        
        <div class="noti-container">
            <h2>🔔 Thông báo của bạn</h2>

            <%
                User user = (User) session.getAttribute("user");
                if (user == null) {
            %>
                <div style="text-align: center; padding: 50px;">
                    <p>Vui lòng đăng nhập để xem thông báo.</p>
                    <a href="index.jsp">Quay lại trang chủ</a>
                </div>
            <%
                } else if ("admin".equals(user.getRole())) {
                    out.print("<div class='empty-msg'>Admin quản lý liên hệ tại trang quản trị.</div>");
                } else {
                    ContactDAO dao = new ContactDAO();
                    List<Map<String, Object>> list = dao.getNotificationsByUser(user.getUsername());

                    if (list == null || list.isEmpty()) {
            %>
                <div style="text-align: center; padding: 50px;">
                    <p>Bạn không có thông báo nào.</p>
                </div>
            <%
                    } else {
                        for (Map<String, Object> n : list) {
                            int isRead = (int) n.get("is_read");
            %>
                <div class="noti-item <%= (isRead == 0) ? "unread" : "" %>">
                    <div class="noti-content">
                        <div class="noti-date">📅 <%= n.get("date") %></div>
                        <div class="noti-msg"><%= n.get("message") %></div>
                    </div>
                </div>
            <%
                        }
                    }
                }
            %>
        </div>
    </div>
</div>

<jsp:include page="Layout/footer.jsp"/>
<jsp:include page="Layout/Chatbox.jsp"/>