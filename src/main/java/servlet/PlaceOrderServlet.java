package servlet;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.Transaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Books;
import model.Order;
import model.OrderItem;
import model.User;
import util.HibernateUtil;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    // GET → redirect to cart
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(request.getContextPath() + "/ViewCartServlet");
    }

    // POST → place order
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession httpSession = request.getSession();

        // ✅ 1. Check login
        User user = (User) httpSession.getAttribute("user");

        if (user == null) {
            httpSession.setAttribute("msg1", "Please login to place order");
            response.sendRedirect(request.getContextPath() + "/user/userLogin.jsp");
            return;
        }

        // ✅ 2. Get cart
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) httpSession.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ViewCartServlet");
            return;
        }

        // ✅ 3. Payment mode
        String paymentMode = request.getParameter("paymentMode");

        if (paymentMode == null || paymentMode.isEmpty()) {
            httpSession.setAttribute("msg1", "Please select a payment mode");
            response.sendRedirect(request.getContextPath() + "/user/selectPayment.jsp");
            return;
        }

        Session session = HibernateUtil.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        // ✅ 4. Create Order
        Order order = new Order();
        order.setUserName(user.getName());
        order.setAddress(user.getAddress());
        order.setOrderDate(new Date());
        order.setStatus("Pending");
        order.setPaymentMode(paymentMode);

        double total = 0;
        order.setTotalAmount(total);

        session.save(order); // save first

        // ✅ 5. Order Items
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {

            int bid = entry.getKey();
            int qty = entry.getValue();

            Books book = session.get(Books.class, bid);
            if (book == null) continue;

            OrderItem item = new OrderItem();

            item.setBookId(book.getBid());
            item.setBookName(book.getBname());
            item.setBookPrice(book.getBprice());
            item.setBookImage(book.getImage());
            item.setQuantity(qty);
            item.setOrder(order);

            total += book.getBprice() * qty;

            session.save(item);
        }

        // ✅ 6. Update total
        order.setTotalAmount(total);
        session.update(order);

        tx.commit();
        session.close();

        // ✅ 7. Clear cart
        httpSession.removeAttribute("cart");

        // ✅ 8. Success page
        response.sendRedirect(request.getContextPath() + "/user/orderSuccess.jsp");
    }
}