/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import Model.User;

/**
 *
 * @author PC
 */
@WebFilter("/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        
        String uri = request.getRequestURI();
        boolean isAdminPage
                = uri.contains("productManager.jsp")
                || uri.contains("addProduct.jsp")
                || uri.contains("updateProduct.jsp")
                || uri.contains("deleteProduct.jsp");

        if (isAdminPage) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null || !"admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
        }

        chain.doFilter(req, res); // cho phép đi tiếp
    }
}
