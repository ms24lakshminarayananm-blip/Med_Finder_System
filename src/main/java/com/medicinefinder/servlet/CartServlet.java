package com.medicinefinder.servlet;

import com.medicinefinder.dao.MedicineDAO;
import com.medicinefinder.dao.OrderDAO;
import com.medicinefinder.model.Medicine;
import com.medicinefinder.model.Order;
import com.medicinefinder.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MedicineDAO medicineDAO = new MedicineDAO();
    private OrderDAO orderDAO = new OrderDAO();

    public static class CartItem implements java.io.Serializable {
        private static final long serialVersionUID = 1L;
        private Medicine medicine;
        private int quantity;

        public CartItem(Medicine medicine, int quantity) {
            this.medicine = medicine;
            this.quantity = quantity;
        }

        public Medicine getMedicine() { return medicine; }
        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }
        public double getTotalPrice() { return medicine.getPrice() * quantity; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("view".equalsIgnoreCase(action) || action == null) {
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }

        if ("checkout".equalsIgnoreCase(action)) {
            User user = (User) session.getAttribute("currentUser");
            if (user == null) {
                request.setAttribute("errorMessage", "Please login to proceed to checkout!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
            return;
        }

        if ("remove".equalsIgnoreCase(action)) {
            String medIdStr = request.getParameter("id");
            if (medIdStr != null) {
                try {
                    int medId = Integer.parseInt(medIdStr);
                    @SuppressWarnings("unchecked")
                    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
                    if (cart != null) {
                        cart.remove(medId);
                    }
                } catch (NumberFormatException ignored) {}
            }
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("add".equalsIgnoreCase(action)) {
            String medIdStr = request.getParameter("medicineId");
            String qtyStr = request.getParameter("quantity");
            int qty = 1;
            try {
                if (qtyStr != null) qty = Integer.parseInt(qtyStr);
            } catch (NumberFormatException ignored) {}

            if (medIdStr != null) {
                try {
                    int medId = Integer.parseInt(medIdStr);
                    Medicine med = medicineDAO.getMedicineById(medId);
                    if (med != null) {
                        @SuppressWarnings("unchecked")
                        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
                        if (cart == null) {
                            cart = new HashMap<>();
                            session.setAttribute("cart", cart);
                        }

                        CartItem item = cart.get(medId);
                        if (item != null) {
                            item.setQuantity(item.getQuantity() + qty);
                        } else {
                            cart.put(medId, new CartItem(med, qty));
                        }
                    }
                } catch (NumberFormatException ignored) {}
            }
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        if ("placeOrder".equalsIgnoreCase(action)) {
            User user = (User) session.getAttribute("currentUser");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            @SuppressWarnings("unchecked")
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                request.setAttribute("errorMessage", "Your cart is empty!");
                request.getRequestDispatcher("/cart.jsp").forward(request, response);
                return;
            }

            List<Order> placedOrders = new ArrayList<>();
            double grandTotal = 0;

            for (CartItem item : cart.values()) {
                Order order = new Order();
                order.setUserId(user.getId());
                order.setMedicineId(item.getMedicine().getId());
                order.setMedicineName(item.getMedicine().getMedicineName());
                order.setQuantity(item.getQuantity());
                order.setTotalPrice(item.getTotalPrice());
                order.setStatus("Confirmed (Demo Payment Successful)");

                boolean created = orderDAO.createOrder(order);
                if (created) {
                    medicineDAO.updateStock(item.getMedicine().getId(), item.getQuantity());
                    placedOrders.add(order);
                    grandTotal += item.getTotalPrice();
                }
            }

            // Clear cart after checkout
            session.removeAttribute("cart");

            request.setAttribute("placedOrders", placedOrders);
            request.setAttribute("grandTotal", grandTotal);
            request.setAttribute("paymentStatus", "Payment Successful (Demo Mode)");
            request.getRequestDispatcher("/orderConfirmation.jsp").forward(request, response);
        }
    }
}
