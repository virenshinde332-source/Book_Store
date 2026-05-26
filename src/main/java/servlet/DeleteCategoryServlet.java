package servlet;

import java.io.IOException;

import org.hibernate.Session;
import org.hibernate.Transaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import util.HibernateUtil;

@WebServlet("/deleteCategory")
public class DeleteCategoryServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String idStr = request.getParameter("id");

		if (idStr == null || idStr.isEmpty()) {
		    response.sendRedirect(request.getContextPath() + "/ViewCategoryServlet");
		    return;
		}

		int id = Integer.parseInt(idStr);

		Session session = HibernateUtil.getFactory().openSession();
		Transaction tx = session.beginTransaction();

		try {

		    Long bookCount = (Long) session
		        .createQuery("select count(b.bid) from Books b where b.category.cid = :catId")
		        .setParameter("catId", id)
		        .uniqueResult();

		    if (bookCount > 0) {
		        tx.rollback();
		        session.close();

		        request.setAttribute("error",
		            "Cannot delete category. Books exist in this category.If you want please delete all Books first.");
		        request.getRequestDispatcher("/ViewCategoryServlet").forward(request, response);
		        return;
		    }

		    Category c = session.get(Category.class, id);

		    if (c != null) {
		        session.delete(c);
		    }

		    tx.commit();

		} catch (Exception e) {
		    tx.rollback();
		    e.printStackTrace();
		}

		session.close();

		response.sendRedirect(request.getContextPath() + "/ViewCategoryServlet");
		}
	}