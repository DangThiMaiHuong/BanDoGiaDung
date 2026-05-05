/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.util.Map;
import Model.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.UserDAO;
import Model.User;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu
        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        if (username == null) {
            username = "";
        }
        if (pass == null) {
            pass = "";
        }

        username = username.trim();
        pass = pass.trim();

        UserDAO dao = new UserDAO();

        // Kiểm tra user
        User userCheck = dao.findByUsername(username);

        // Không tồn tại
        if (userCheck == null) {
            response.sendRedirect("index.jsp?msg=not_exist");
            return;
        }

        // Sai password
        String dbPass = userCheck.getPassword();

        if (dbPass == null || !dbPass.equals(pass)) {
            response.sendRedirect("index.jsp?msg=wrong_pass&username=" + java.net.URLEncoder.encode(username, "UTF-8"));
            return;
        }

        // Login thành công
        HttpSession session = request.getSession();
        session.setAttribute("user", userCheck);

        // Reset cart
        session.removeAttribute("cart");

        ProductDAO pDao = new ProductDAO();
        Map<Integer, Integer> dbCart = pDao.getCartFromDB(userCheck.getUsername());

        if (dbCart != null && !dbCart.isEmpty()) {
            session.setAttribute("cart", dbCart);
        }

        if ("admin".equals(userCheck.getRole())) {
            response.sendRedirect("productManager.jsp");   // admin
        } else {
            response.sendRedirect("index.jsp?msg=success"); // user
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
//    @Override
//    public String getServletInfo() {
    //       return "Short description";
    //   }// </editor-fold>
}
