package servlet;

import java.io.IOException;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Books;
import util.HibernateUtil;

@WebServlet("/ProductsByCategory")
public class ProductsByCategoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int cid = Integer.parseInt(request.getParameter("cid"));

        Session session = HibernateUtil.getFactory().openSession();

        Query<Books> q = session.createQuery(
            "from Books where category.cid = :cid", Books.class
        );

        q.setParameter("cid", cid);

        List<Books> books = q.list();

        session.close();

        request.setAttribute("books", books);

        request.getRequestDispatcher("/user/products.jsp")
               .forward(request, response);
    }
}