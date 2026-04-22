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

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

/**
 *
 * @author PC
 */
public class ChatBoxAI extends HttpServlet {

    String API_KEY = System.getenv("GROQ_API_KEY");

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
            out.println("<title>Servlet ChatBoxAI</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChatBoxAI at " + request.getContextPath() + "</h1>");
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
        request.setCharacterEncoding("UTF-8");

        String message = request.getParameter("message");

        String reply = callAI(message);
        reply = formatProductLinks(reply);
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(reply);
    }

    private String norm(String s) {
        if (s == null) {
            return "";
        }
        return s.toLowerCase().trim();
    }

    private String formatProductLinks(String text) {

        if (text == null) {
            return "";
        }

        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAll();

        String result = text;

        // sort để tránh match sai
        list.sort((a, b) -> b.getName().length() - a.getName().length());

        for (Product p : list) {

            String name = p.getName();
            if (name == null) {
                continue;
            }

            String nameNorm = norm(name);
            String textNorm = norm(result);

            // CHỈ CHECK trước
            if (textNorm.contains(nameNorm)) {

                String link
                        = "<a href='detail.jsp?id=" + p.getId() + "'>"
                        + "<b>" + name + "</b></a>";

                // replace trực tiếp tên gốc
                result = result.replace(name, link);
            }
        }

        return result;
    }

    private String callAI(String message) {
        System.out.println("KEY = [" + API_KEY + "]");
        try {

            // LẤY DATA TỪ DB
            ProductDAO dao = new ProductDAO();
            List<Product> list;

            String msgLower = message.toLowerCase();

            if (msgLower.contains("tivi")) {
                list = dao.getByCategory("tivi");
            } else if (msgLower.contains("máy giặt")) {
                list = dao.getByCategory("maygiat");
            } else if (msgLower.contains("tủ lạnh")) {
                list = dao.getByCategory("tulanh");
            } else if (msgLower.contains("nồi")) {
                list = dao.getByCategory("noi");
            } else if (msgLower.contains("nồi cơm điện")) {
                list = dao.getByCategory("noicomdien");
            } else if (msgLower.contains("máy lọc nước")) {
                list = dao.getByCategory("maylocnuoc");
            } else if (msgLower.contains("quạt")) {
                list = dao.getByCategory("quat");
            } else {
                list = dao.getAll();
            }

            // CHUYỂN SANG TEXT
            StringBuilder productData = new StringBuilder();

            for (Product p : list) {
                productData.append("- ")
                        .append(p.getName())
                        .append(" | Giá: ")
                        .append(p.getPrice())
                        .append(p.getId())
                        .append(" VNĐ\n");
            }

            URL url = new URL("https://api.groq.com/openai/v1/chat/completions");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // PROMPT CÓ DATABASE
            String json = "{"
                    + "\"model\":\"llama-3.1-8b-instant\","
                    + "\"messages\":["
                    + "{"
                    + "\"role\":\"system\","
                    + "\"content\":\"Bạn là nhân viên bán đồ gia dụng. "
                    + "Dưới đây là danh sách sản phẩm:\\n"
                    + productData.toString().replace("\n", "\\n")
                    + "\\nHãy tư vấn dựa trên danh sách này. Không được bịa\""
                    + "},"
                    + "{"
                    + "\"role\":\"user\","
                    + "\"content\":\"" + message + "\""
                    + "}"
                    + "]"
                    + "}";

            OutputStream os = conn.getOutputStream();
            os.write(json.getBytes("UTF-8"));
            os.close();

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "UTF-8")
            );

            StringBuilder result = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                result.append(line);
            }
            String res = result.toString();
            System.out.println("AI RESPONSE: " + res);
            String marker = "\"content\":\"";
            int start = res.indexOf(marker);

            if (start == -1) {
                return "AI lỗi";
            }

            start += marker.length();
            int end = res.indexOf("\"", start);

            if (end == -1) {
                return "AI lỗi";
            }

            return res.substring(start, end).replace("\\n", "\n");
        } catch (Exception e) {
            e.printStackTrace();
            return "AI đang bận";
        }
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
