<%-- 
    Document   : index
    Created on : Apr 6, 2026, 8:06:46 PM
    Author     : PC
--%>

<%@page import="java.util.List"%>
<%@page import="Model.ProductDAO"%>
<%@page import="Model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style.css" rel="stylesheet">

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Điện Máy Mini</title>
    </head>
    <body>
        <!-- BANNER -->
        <div class="banner">
            <img src="images/banner.png"/>
        </div>

        <!-- HEADER + MENU -->
        <jsp:include page="Layout/header.jsp"/>
        <jsp:include page="Layout/menu.jsp"/>

        <div class="main">

            <!-- LEFT MENU -->
            <jsp:include page="Layout/left.jsp"/>

            <!-- CONTENT -->
            <div class="content">
                <!-- MENU PRODUCT TYPE -->
                <jsp:include page="Layout/ProductType.jsp"/>

                <%
                    String category = request.getParameter("category");
                    String typeParam = request.getParameter("type");
                    int type = 0;

                    if (typeParam != null && !typeParam.isEmpty()) {
                        type = Integer.parseInt(typeParam);
                    }

                    ProductDAO dao = new ProductDAO();
                    List<Product> list = null;

                    if (category != null && !category.trim().equals("")) {
                        list = dao.getByCategory(category);
                    } else if (type != 0) {
                        list = dao.getProductByType(type);
                    } else {
                        list = dao.getAll();
                    }
                %>
                <%
                    String displayName = "";

                    if (category != null && !category.equals("")) {
                        displayName = "Danh mục ";
                        switch (category) {
                            case "tulanh":
                                displayName += "Tủ lạnh";
                                break;
                            case "maygiat":
                                displayName += "Máy giặt";
                                break;
                            case "tivi":
                                displayName += "Tivi";
                                break;
                            case "dieuhoa":
                                displayName += "Điều hòa";
                                break;
                            case "noicomdien":
                                displayName += "Nồi cơm điện";
                                break;
                            case "quat":
                                displayName += "Quạt";
                                break;
                            case "maylocnuoc":
                                displayName += "Máy lọc nước";
                                break;
                            case "noi":
                                displayName += "Nồi";
                                break;
                            default:
                                displayName += category.toUpperCase();
                        }
                    } else if (type != 0) {
                        switch (type) {
                            case 1:
                                displayName = "Sản phẩm nổi bật";
                                break;
                            case 2:
                                displayName = "Sản phẩm giảm giá";
                                break;
                            case 3:
                                displayName = "Sản phẩm mới";
                                break;
                        }
                    }
                %>

                <h3><%= displayName%></h3>

                <!--HIỂN THỊ SẢN PHẨM-->

                <div class="grid">
                    <%
                        for (Product p : list) {
                    %>

                    <div class="product">

                        <% if (p.getType() == 1) { %>
                        <div class="label hot">🔥 HOT</div>
                        <% } %>

                        <% if (p.getType() == 2) { %>
                        <div class="label sale">💥 SALE</div>
                        <% } %>

                        <% if (p.getType() == 3) { %>
                        <div class="label new">🆕 NEW</div>
                        <% }%>

                        <a href="detail.jsp?id=<%=p.getId()%>" class="product-link">
                            <img src="<%=p.getImage()%>">
                            <h4><%=p.getName()%></h4>
                        </a>

                        <% if (p.getType() == 2 && p.getDiscount_percent() != null && p.getDiscount_percent() > 0) {%>

                        <p class="old-price">
                            <%= String.format("%,d VNĐ", p.getPrice()).replace(",", ".")%>
                        </p>

                        <p class="product-price">
                            <%= String.format("%,.0f VNĐ", p.getFinalPrice()).replace(",", ".")%>
                        </p>

                        <span class="discount">
                            -<%=p.getDiscount_percent()%>%
                        </span>

                        <% } else {%>

                        <p class="product-price">
                            <%= String.format("%,d VNĐ", p.getPrice()).replace(",", ".")%>
                        </p>

                        <% }%>
                        <div class="btn">
                            <a href="detail.jsp?id=<%=p.getId()%>">Xem chi tiết</a>

                            <a href="Detail?id=<%=p.getId()%>" class="btn-cart-quick" title="Thêm vào giỏ hàng">
                                🛒
                            </a>
                        </div>

                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

        <!-- FOOTER -->
        <jsp:include page="Layout/footer.jsp"/>

        <!-- CHATBOX -->
        <jsp:include page="Layout/Chatbox.jsp"/>
    </body>
</html>
