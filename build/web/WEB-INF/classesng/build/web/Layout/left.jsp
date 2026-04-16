<%-- 
    Document   : left
    Created on : Apr 6, 2026, 8:37:58 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String c = request.getParameter("category");
%>

<div class="left">
    <h3>Danh mục</h3>
    <ul>
        <li>
            <a href="index.jsp" class="<%= (c == null) ? "active" : "" %>">
                Tất cả
            </a>
        </li>

        <li>
            <a href="index.jsp?category=tulanh" 
               class="<%= "tulanh".equals(c) ? "active" : "" %>">
               Tủ lạnh
            </a>
        </li>

        <li>
            <a href="index.jsp?category=maygiat" 
               class="<%= "maygiat".equals(c) ? "active" : "" %>">
               Máy giặt
            </a>
        </li>

        <li>
            <a href="index.jsp?category=tivi" 
               class="<%= "tivi".equals(c) ? "active" : "" %>">
               Tivi
            </a>
        </li>

        <li>
            <a href="index.jsp?category=dieuhoa" 
               class="<%= "dieuhoa".equals(c) ? "active" : "" %>">
               Điều hòa
            </a>
        </li>
        
        <li>
            <a href="index.jsp?category=noicomdien" 
               class="<%= "noicomdien".equals(c) ? "active" : "" %>">
               Nồi cơm điện
            </a>
        </li>
        
        <li>
            <a href="index.jsp?category=quat" 
               class="<%= "quat".equals(c) ? "active" : "" %>">
               Quạt
            </a>
        </li>
        
        <li>
            <a href="index.jsp?category=maylocnuoc" 
               class="<%= "maylocnuoc".equals(c) ? "active" : "" %>">
               Máy lọc nước
            </a>
        </li>
        
        <li>
            <a href="index.jsp?category=noi" 
               class="<%= "noi".equals(c) ? "active" : "" %>">
               Nồi
            </a>
        </li>
    </ul>
</div>
