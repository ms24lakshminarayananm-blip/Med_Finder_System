package com.medicinefinder.servlet;

import com.medicinefinder.dao.MedicineDAO;
import com.medicinefinder.model.Medicine;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


public class MedicineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MedicineDAO medicineDAO = new MedicineDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String format = request.getParameter("format");
        String query = request.getParameter("query");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String idStr = request.getParameter("id");

        // Single Medicine Details
        if ("details".equalsIgnoreCase(action) || (idStr != null && !idStr.trim().isEmpty())) {
            try {
                int id = Integer.parseInt(idStr);
                Medicine med = medicineDAO.getMedicineById(id);
                request.setAttribute("medicine", med);
                request.getRequestDispatcher("/medicineDetails.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid Medicine ID");
            }
        }

        Double maxPrice = null;
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try {
                maxPrice = Double.parseDouble(priceStr);
            } catch (NumberFormatException ignored) {}
        }

        List<Medicine> list = medicineDAO.searchMedicines(query, category, maxPrice);

        // Check if AJAX request or JSON format requested (Exercise 9A / 9B)
        boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With")) || "json".equalsIgnoreCase(format);

        if (isAjax) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < list.size(); i++) {
                Medicine m = list.get(i);
                json.append("{")
                    .append("\"id\":").append(m.getId()).append(",")
                    .append("\"name\":\"").append(escapeJson(m.getMedicineName())).append("\",")
                    .append("\"category\":\"").append(escapeJson(m.getCategory())).append("\",")
                    .append("\"price\":").append(m.getPrice()).append(",")
                    .append("\"quantity\":").append(m.getQuantity()).append(",")
                    .append("\"pharmacyName\":\"").append(escapeJson(m.getPharmacyName() != null ? m.getPharmacyName() : "")).append("\",")
                    .append("\"pharmacyLocation\":\"").append(escapeJson(m.getPharmacyLocation() != null ? m.getPharmacyLocation() : "")).append("\"")
                    .append("}");
                if (i < list.size() - 1) json.append(",");
            }
            json.append("]");
            out.print(json.toString());
            out.flush();
        } else {
            request.setAttribute("medicineList", list);
            request.setAttribute("searchQuery", query);
            request.setAttribute("selectedCategory", category);
            request.setAttribute("maxPrice", priceStr);
            request.getRequestDispatcher("/search.jsp").forward(request, response);
        }
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}
