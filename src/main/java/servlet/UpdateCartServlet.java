package servlet;

import java.io.IOException;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bidParam = request.getParameter("bid");
        String action = request.getParameter("action");

        // ✅ Validate bid
        if (bidParam == null || bidParam.isEmpty()) {
            response.sendRedirect("ViewCartServlet");
            return;
        }

        int bid;
        try {
            bid = Integer.parseInt(bidParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("ViewCartServlet");
            return;
        }

        HttpSession session = request.getSession();
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart != null && cart.containsKey(bid)) {

            int qty = cart.get(bid);

            if ("inc".equals(action)) {
                cart.put(bid, qty + 1);
            }
            else if ("dec".equals(action)) {
                if (qty > 1) {
                    cart.put(bid, qty - 1);
                } else {
                    cart.remove(bid);
                }
            }
            else if ("remove".equals(action)) {
                cart.remove(bid);
            }
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("ViewCartServlet");
    }
}