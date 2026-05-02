/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author pc
 */
@WebServlet(name = "Detail", urlPatterns = {"/Detail"})
public class Detail extends HttpServlet {

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
            out.println("<title>Servlet Detail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Detail at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));
        // Thêm tham số action để biết là tăng hay giảm
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        Model.User user = (Model.User) session.getAttribute("user");

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        // XỬ LÝ LOGIC SỐ LƯỢNG
        int currentQty = cart.getOrDefault(id, 0);

        if ("decrease".equals(action)) {
            if (currentQty > 1) {
                cart.put(id, currentQty - 1);
            } else {
                cart.remove(id); // Giảm xuống 0 thì xóa khỏi giỏ
            }
        } else {
            // Mặc định (khi nhấn dấu + hoặc nhấn "Thêm giỏ hàng") là tăng lên 1
            cart.put(id, currentQty + 1);
        }

        session.setAttribute("cart", cart);

        // ĐỒNG BỘ VÀO DATABASE
        if (user != null) {
            ProductDAO dao = new ProductDAO();
            if (cart.containsKey(id)) {
                dao.CartToDB(user.getId(), user.getUsername(), id, cart.get(id));
            } else {
                // Nếu sản phẩm đã bị remove khỏi map (do giảm xuống 0)
                dao.CartToDB(null, null, id, cart.get(id));
            }
        }

        // Chuyển hướng về trang trước đó (giỏ hàng hoặc trang chi tiết)
        response.sendRedirect(request.getHeader("referer"));
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
