package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String contextPath = request.getContextPath();

        // ✅ Change pid → bid
        String bidParam = request.getParameter("bid");
        String qtyParam = request.getParameter("qty");

        // Validate Book ID
        if (bidParam == null || bidParam.isEmpty()) {
            response.sendRedirect(contextPath + "/home.jsp");
            return;
        }

        int bid;
        int qty = 1;

        try {
            bid = Integer.parseInt(bidParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(contextPath + "/home.jsp");
            return;
        }

        // Validate Quantity
        try {
            if (qtyParam != null) {
                qty = Integer.parseInt(qtyParam);
                if (qty < 1) qty = 1;
            }
        } catch (NumberFormatException e) {
            qty = 1;
        }

        HttpSession session = request.getSession();

        // Cart: bookId → quantity
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        // ✅ Add book to cart
        cart.put(bid, cart.getOrDefault(bid, 0) + qty);

        session.setAttribute("cart", cart);

        // Redirect back
        String referer = request.getHeader("referer");

        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(contextPath + "/CartServlet");
        }
    }
}