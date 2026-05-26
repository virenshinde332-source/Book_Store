package servlet;

import java.io.IOException;

import org.hibernate.Session;
import org.hibernate.Transaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Category;
import util.HibernateUtil;

@WebServlet("/EditCategoryServlet")
public class EditCategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // 🔹 LOAD CATEGORY
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int cid = Integer.parseInt(request.getParameter("id"));

        Session session = HibernateUtil.getFactory().openSession();
        Category category = session.get(Category.class, cid);
        session.close();

        request.setAttribute("category", category);
        request.getRequestDispatcher("/admin/editCategory.jsp")
               .forward(request, response);
    }

    // 🔹 UPDATE CATEGORY
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int cid = Integer.parseInt(request.getParameter("cid"));
        String cname = request.getParameter("cname");

        Session session = HibernateUtil.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        Category category = session.get(Category.class, cid);

        if (category != null) {
            category.setCname(cname);
            session.update(category);
        }

        tx.commit();
        session.close();

        response.sendRedirect(request.getContextPath() + "/ViewCategoryServlet");
    }
}