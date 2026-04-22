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
    <a class="<%= (c == null || c.equals("")) ? "active" : "" %>"
        href="index.jsp">Trang chủ</a>

    <a class="<%= "tulanh".equals(c) ? "active" : ""%>"
       href="index.jsp?category=tulanh">Tủ lạnh</a>

    <a class="<%= "maygiat".equals(c) ? "active" : ""%>"
       href="index.jsp?category=maygiat">Máy giặt</a>

    <a class="<%= "tivi".equals(c) ? "active" : ""%>"
       href="index.jsp?category=tivi">Tivi</a>

    <a class="<%= "dieuhoa".equals(c) ? "active" : ""%>"
       href="index.jsp?category=dieuhoa">Điều hòa</a>
       
    <a class="<%= "noicomdien".equals(c) ? "active" : ""%>"
       href="index.jsp?category=noicomdien">Nồi cơm điện</a>
       
    <a class="<%= "quat".equals(c) ? "active" : ""%>"
       href="index.jsp?category=quat">Quạt</a>
       
    <a class="<%= "maylocnuoc".equals(c) ? "active" : ""%>"
       href="index.jsp?category=maylocnuoc">Máy lọc nước</a>
       
    <a class="<%= "noi".equals(c) ? "active" : ""%>"
       href="index.jsp?category=noi">Nồi</a>
</div>