<%-- 
    Document   : contactManager
    Created on : May 9, 2026, 6:17:56 PM
    Author     : pc
--%>
<%@page import="java.util.List"%>
<%@page import="Model.Contact"%>
<%@page import="Model.ContactDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style.css" rel="stylesheet">

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Liên hệ</title>
    </head>
    <body>
        <!-- BANNER -->
        <div class="banner">
            <img src="images/banner.png"/>
        </div>
        <jsp:include page="Layout/header.jsp"/>
        <jsp:include page="Layout/menu.jsp"/>

        <div class="main">
            <jsp:include page="Layout/left.jsp"/>

            <div class="content admin-page">
                <h1 style="text-align: center">DANH SÁCH LIÊN HỆ</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Message</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Đảm bảo đã tạo class ContactDAO và phương thức getAllContacts()
                            ContactDAO dao = new ContactDAO();
                            List<Contact> cList = dao.getAllContacts();
                            if (cList != null) {
                                for (Contact c : cList) {
                        %>
                        <tr>
                            <td><%=c.getName()%></td>
                            <td><%=c.getEmail()%></td>
                            <td><%=c.getMessage()%></td>
                            <td style="text-align: center;">
                                <%
                                    // Kiểm tra xem đã có nội dung trong reply_message chưa
                                    String rep = c.getReplyMessage();
                                    if (rep == null || rep.trim().isEmpty()) {
                                %>
                                <button onclick="openReplyModal('<%=c.getId()%>', '<%=c.getName()%>', '<%=c.getEmail()%>')" 
                                        style="display: inline-block; padding: 5px 15px; background-color: #ffb100; border: none; color: white; border-radius: 4px; cursor: pointer;">
                                    Reply
                                </button>
                                <% } else {%>
                                <div style="font-size: 11px; color: #27ae60; font-weight: bold; margin-bottom: 3px;">✓ Đã rep</div>
                                <a href="UnreplyController?id=<%=c.getId()%>" 
                                   style="display: inline-block; padding: 3px 10px; background-color: #e74c3c; color: white; border-radius: 4px; text-decoration: none; font-size: 12px;"
                                   onclick="return confirm('Bạn muốn hủy trạng thái đã phản hồi?')">
                                    Unreply
                                </a>
                                <% } %>
                            </td>
                        </tr>
                        <%      }
                            }%>
                    </tbody>
                </table>
            </div>
        </div>
        <jsp:include page="Layout/footer.jsp"/>
        <jsp:include page="Layout/Chatbox.jsp"/>
        <div id="replyModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,0.6); font-family: Arial, sans-serif;">
            <div style="background:white; margin:8% auto; padding:25px; width:450px; border-radius:10px; box-shadow: 0 5px 20px rgba(0,0,0,0.3);">
                <h2 style="margin-top:0; color: #333; border-bottom: 2px solid #ffb100; padding-bottom: 10px;">Phản hồi khách hàng</h2>

                <form action="SendNotifyController" method="POST">
                    <%--Thêm input ẩn để giữ ID của bản ghi liên hệ --%>
                    <input type="hidden" name="id" id="displayId">
                    <div style="margin-bottom: 15px;">
                        <label style="display:block; font-weight:bold; margin-bottom:5px;">Username:</label>
                        <input type="text" name="username" id="displayUser" readonly 
                               style="width:100%; padding:10px; border:1px solid #ddd; border-radius:5px; background:#f9f9f9; color:#555;">
                    </div>

                    <div style="margin-bottom: 15px;">
                        <label style="display:block; font-weight:bold; margin-bottom:5px;">Email:</label>
                        <input type="text" name="email" id="displayEmail" readonly 
                               style="width:100%; padding:10px; border:1px solid #ddd; border-radius:5px; background:#f9f9f9; color:#555;">
                    </div>

                    <div style="margin-bottom: 15px;">
                        <label style="display:block; font-weight:bold; margin-bottom:5px;">Nội dung thông báo:</label>
                        <textarea name="message" rows="5" required
                                  style="width:100%; padding:10px; border:1px solid #ddd; border-radius:5px; resize:none; font-family: inherit;" 
                                  placeholder="Nhập nội dung thông báo gửi đến người dùng..."></textarea>
                    </div>

                    <div style="text-align: right; margin-top: 20px;">
                        <button type="button" onclick="closeModal()" 
                                style="padding: 10px 20px; background:#e74c3c; color:white; border:none; border-radius:5px; cursor:pointer; margin-right:10px;">Hủy bỏ</button>
                        <button type="submit" 
                                style="padding: 10px 20px; background:#27ae60; color:white; border:none; border-radius:5px; cursor:pointer; font-weight:bold;">Gửi thông báo</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function openReplyModal(id,username, email) {
                // Điền dữ liệu vào các ô input trong Modal
                document.getElementById('displayId').value = id;
                document.getElementById('displayUser').value = username;
                document.getElementById('displayEmail').value = email;

                // Hiển thị Modal
                document.getElementById('replyModal').style.display = 'block';
            }

            function closeModal() {
                document.getElementById('replyModal').style.display = 'none';
            }

            // Đóng modal khi click ra ngoài vùng trắng
            window.onclick = function (event) {
                var modal = document.getElementById('replyModal');
                if (event.target == modal) {
                    closeModal();
                }
            }
        </script>
    </body>
</html>