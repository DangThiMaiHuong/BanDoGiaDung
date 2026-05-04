/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Product;
import Model.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PC
 */
public class AddProduct extends HttpServlet {

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
        try {
            response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("UTF-8");
            String tensp = request.getParameter("name");
            long gia = Long.parseLong(request.getParameter("price"));
            String anh = request.getParameter("image");
            String mota = request.getParameter("description");
            String loai = request.getParameter("category");
            int type = Integer.parseInt(request.getParameter("type"));
            int sale = Integer.parseInt(request.getParameter("discount_percent"));
            ProductDAO dao = new ProductDAO();
            // kiểm tra tồn tại sản phẩm?
            if (dao.isProductExistByName(tensp)) {
                response.sendRedirect("addProduct.jsp?error=exist"
                        + "&price=" + java.net.URLEncoder.encode(String.valueOf(gia), "UTF-8")                    
                        + "&image=" + java.net.URLEncoder.encode(anh, "UTF-8")
                        + "&description=" + java.net.URLEncoder.encode(mota, "UTF-8")
                        + "&category=" + java.net.URLEncoder.encode(loai, "UTF-8")
                        + "&type=" + java.net.URLEncoder.encode(String.valueOf(type), "UTF-8")
                        + "&sale=" + java.net.URLEncoder.encode(String.valueOf(sale), "UTF-8")
                );
                return;
            }
            if (type != 2) { // 2 = SALE
                sale = 0;
            }           
            Product p = new Product(tensp, gia, anh, mota, loai, type, sale);
            if(new ProductDAO().addProduct(p)){
                response.sendRedirect("productManager.jsp");
            }
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet AddProduct</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Servlet AddProduct at " + request.getContextPath() + "</h1>");
                out.println("</body>");
                out.println("</html>");
            }
        }   catch (SQLException ex) {
            Logger.getLogger(AddProduct.class.getName()).log(Level.SEVERE, null, ex);
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
