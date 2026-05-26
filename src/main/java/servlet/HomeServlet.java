package servlet;

import java.io.IOException;
import java.util.List;

import org.hibernate.Session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Books;
import model.Category;
import util.HibernateUtil;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Session session = HibernateUtil.getFactory().openSession();

        // 📚 Categories
        List<Category> categories =
                session.createQuery("from Category", Category.class).list();

        // 📖 Featured Books
        List<Books> featuredBooks =
                session.createQuery("from Books", Books.class)
                       .setMaxResults(8)
                       .list();

        session.close();

        request.setAttribute("categories", categories);
        request.setAttribute("featuredBooks", featuredBooks);

        request.getRequestDispatcher("/user/home.jsp")
               .forward(request, response);
    }
}