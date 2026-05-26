package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.hibernate.Session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Books;
import util.HibernateUtil;

@WebServlet("/ViewCartServlet")
public class ViewCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession httpSession = request.getSession();

        // 📦 Cart from session
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) httpSession.getAttribute("cart");

        // 📚 Book map
        Map<Integer, Books> books = new HashMap<>();

        if (cart != null && !cart.isEmpty()) {

            Session session = HibernateUtil.getFactory().openSession();

            for (Integer bid : cart.keySet()) {

                Books b = session.get(Books.class, bid);

                if (b != null) {
                    books.put(bid, b);
                }
            }

            session.close();
        }

        request.setAttribute("cart", cart);
        request.setAttribute("books", books);

        request.getRequestDispatcher("/user/cart.jsp")
               .forward(request, response);
    }
}