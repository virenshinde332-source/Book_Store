package servlet;

import java.io.IOException;

import org.hibernate.Session;
import org.hibernate.Transaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Category;
import util.HibernateUtil;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ✅ LOAD FORM (Add OR Edit)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cidStr = request.getParameter("cid");

        if (cidStr != null && !cidStr.isEmpty()) {

            int cid = Integer.parseInt(cidStr);

            Session session = HibernateUtil.getFactory().openSession();
            Category category = session.get(Category.class, cid);
            session.close();

            if (category != null) {
                request.setAttribute("category", category);
            }
        }

        // 🔥 SAME JSP FOR BOTH ADD + EDIT
        request.getRequestDispatcher("/admin/addCategory.jsp")
               .forward(request, response);
    }

    // ✅ SAVE OR UPDATE
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cidStr = request.getParameter("cid"); // hidden field
        String cname = request.getParameter("cname");

        Session session = HibernateUtil.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        if (cidStr == null || cidStr.isEmpty()) {

            // ➕ ADD CATEGORY
            Category category = new Category();
            category.setCname(cname);

            session.save(category);

        } else {

            // ✏️ UPDATE CATEGORY
            int cid = Integer.parseInt(cidStr);

            Category category = session.get(Category.class, cid);

            if (category != null) {
                category.setCname(cname);
                session.update(category);
            }
        }

        tx.commit();
        session.close();

        response.sendRedirect(request.getContextPath() + "/ViewCategoryServlet");
    }
}