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

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("q");

        Session session = HibernateUtil.getFactory().openSession();

        Query<Books> query = session.createQuery(
            "from Books where bname like :key or bauthor like :key or category like :key",
            Books.class
        );

        query.setParameter("key", "%" + keyword + "%");

        List<Books> books = query.list();

        session.close();

        request.setAttribute("books", books);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("/user/search.jsp")
               .forward(request, response);
    }
}