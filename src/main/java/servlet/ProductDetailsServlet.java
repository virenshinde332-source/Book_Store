package servlet;

import java.io.IOException;

import org.hibernate.Session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Books;
import util.HibernateUtil;

@WebServlet("/ProductDetailsServlet")
public class ProductDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        String idParam = request.getParameter("id");

        // ✅ Validate ID
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int id;

        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        Session session = HibernateUtil.getFactory().openSession();

        Books book = session.get(Books.class, id);

        session.close();

        // ✅ Handle null book
        if (book == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.setAttribute("book", book);

        request.getRequestDispatcher("/user/product-details.jsp")
               .forward(request, response);
    }
}