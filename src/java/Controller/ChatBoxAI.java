/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Product;
import Model.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

        // lấy câu hỏi từ user
        String message = request.getParameter("message");

        // gửi message lên AI
        String reply = callAI(message);

        // gắn link sản phẩm
        reply = formatProductLinks(reply);
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(reply);
    }

    // chuẩn hóa text
    private String norm(String s) {
        if (s == null) {
            return "";
        }
        return s.toLowerCase().trim();
    }

    // tên sản phẩm là link click tới trang chi tiết sản phẩm đó
    private String formatProductLinks(String text) {

        if (text == null) {
            return "";
        }

        // lấy danh sách sản phẩm
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAll();

        String result = text;

        // sort để tránh match sai
        // sắp xếp theo độ dài tên giảm dần
        list.sort((a, b) -> b.getName().length() - a.getName().length());

        for (Product p : list) {

            String name = p.getName();
            if (name == null) {
                continue;
            }

            String nameNorm = norm(name);

            // chỉ check trước
            if (norm(result).contains(nameNorm)) {

                String link
                        = "<a href='detail.jsp?id=" + p.getId() + "'>"
                        + "<b>" + name + "</b></a>";

                // replace trực tiếp tên gốc
                result = result.replaceAll("\\b" + Pattern.quote(name) + "\\b", Matcher.quoteReplacement(link));
            }
        }

        return result;
    }

    private String escapeJson(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n");
    }

    private String callAI(String message) {
        System.out.println("KEY = [" + API_KEY + "]");
        try {

            // lấy data từ database
            ProductDAO dao = new ProductDAO();
            List<Product> list;

            String msgLower = message.toLowerCase();

            // lọc sản phẩm theo câu hỏi
            if (msgLower.contains("tivi")) {
                list = dao.getByCategory("tivi");
            } else if (msgLower.contains("máy giặt")) {
                list = dao.getByCategory("maygiat");
            } else if (msgLower.contains("tủ lạnh")) {
                list = dao.getByCategory("tulanh");
            } else if (msgLower.contains("nồi cơm điện")) {
                list = dao.getByCategory("noicomdien");
            } else if (msgLower.contains("nồi")) {
                list = dao.getByCategory("noi");
            } else if (msgLower.contains("máy lọc nước")) {
                list = dao.getByCategory("maylocnuoc");
            } else if (msgLower.contains("quạt")) {
                list = dao.getByCategory("quat");
            } else {
                list = dao.getAll();
            }

            // chuyển database sang text
            StringBuilder productData = new StringBuilder();

            for (Product p : list) {
                productData.append(String.format(
                        "- %s | Giá: %,d VNĐ | ID: %d\n",
                        p.getName(),
                        p.getPrice(),
                        p.getId()
                ));
            }

            URL url = new URL("https://api.groq.com/openai/v1/chat/completions");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // prompt có database
            String json = "{"
                    + "\"model\":\"llama-3.1-8b-instant\","
                    + "\"messages\":["
                    + "{"
                    + "\"role\":\"system\","
                    + "\"content\":\"Bạn là nhân viên bán đồ gia dụng. "
                    + "Dưới đây là danh sách sản phẩm:\\n"
                    + escapeJson(productData.toString())
                    + "\\nHãy tư vấn dựa trên danh sách này. "
                    + "Chỉ được tư vấn sản phẩm trong danh sách trên. "
                    + "Nếu không có thì nói không có. "
                    + "Không được bịa. Bám sát vào dữ liệu tôi gửi. Chú ý đúng giá sản phẩm\""
                    + "},"
                    + "{"
                    + "\"role\":\"user\","
                    + "\"content\":\"" + escapeJson(message) + "\""
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
        } catch (IOException e) {
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
