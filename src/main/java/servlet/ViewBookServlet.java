package servlet;

import java.io.IOException;
import java.util.List;

import org.hibernate.Session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Books;
import util.HibernateUtil;

@WebServlet("/ViewBookServlet")
public class ViewBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Session session = HibernateUtil.getFactory().openSession();

        List<Books> books = session
                .createQuery("from Books", Books.class)
                .list();

        session.close();

        request.setAttribute("books", books);

        request.getRequestDispatcher("admin/adminViewBook.jsp")
               .forward(request, response);
    }
}