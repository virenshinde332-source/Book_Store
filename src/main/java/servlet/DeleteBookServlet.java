package servlet;

import java.io.File;
import java.io.IOException;

import org.hibernate.Session;
import org.hibernate.Transaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Books;
import util.HibernateUtil;

@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bidStr = request.getParameter("bid");

        if (bidStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/book");
            return;
        }

        int bid = Integer.parseInt(bidStr);

        Session session = HibernateUtil.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        Books b = session.get(Books.class, bid);

        if (b != null) {

            // 🖼 Delete Image
            String img = b.getImage();
            if (img != null && !img.isEmpty()) {

                File file = new File(
                    getServletContext().getRealPath("/uploads/books/")
                    + File.separator + img
                );

                if (file.exists()) file.delete();
            }

            // 🗑 Delete Book
            session.delete(b);
        }

        tx.commit();
        session.close();

        response.sendRedirect(request.getContextPath() + "/ViewBookServlet");
    }
}