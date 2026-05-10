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

<%
    // 1. KIỂM TRA QUYỀN TRUY CẬP NGAY ĐẦU TRANG
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    } else if ("admin".equals(user.getRole())) {
        response.sendRedirect("contactManager.jsp");
        return;
    }
%>

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
                // 2. LẤY DỮ LIỆU THÔNG BÁO (Lúc này chắc chắn là User thường đã login)
                ContactDAO dao = new ContactDAO();
                dao.markAllAsRead(user.getUsername());
                List<Map<String, Object>> list = dao.getNotificationsByUser(user.getUsername());

                if (list == null || list.isEmpty()) {
            %>
            <div style="text-align: center; padding: 50px;">
                <p>Bạn không có thông báo nào.</p>
            </div>
            <%
            } else {
                for (Map<String, Object> n : list) {
                    // Tránh lỗi ép kiểu nếu dữ liệu là Long hoặc Integer
                    int isRead = Integer.parseInt(n.get("is_read").toString());
            %>
            <div class="noti-item <%= (isRead == 0) ? "unread" : ""%>">
                <div class="noti-content">
                    <div class="noti-date">📅 <%= n.get("date")%></div>
                    <div class="noti-msg"><%= n.get("message")%></div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</div>

<jsp:include page="Layout/footer.jsp"/>
<jsp:include page="Layout/Chatbox.jsp"/>