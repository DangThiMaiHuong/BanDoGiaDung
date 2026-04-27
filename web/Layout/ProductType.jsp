<%-- 
    Document   : ProductType
    Created on : Apr 22, 2026, 11:51:08 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="special-titles">

    <h2>
        <a href="Type?type=0">Tất cả sản phẩm</a>
    </h2>

    <h2 class="${activeType == 1 ? 'active' : ''}">
        <a href="Type?type=1">Sản phẩm nổi bật</a>
    </h2>

    <h2 class="${activeType == 2 ? 'active' : ''}">
        <a href="Type?type=2">Sản phẩm giảm giá</a>
    </h2>

    <h2 class="${activeType == 3 ? 'active' : ''}">
        <a href="Type?type=3">Sản phẩm mới</a>
    </h2>
</div>
