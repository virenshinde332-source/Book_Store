package servlet;

import java.io.File;
import java.io.IOException;

import org.hibernate.Session;
import org.hibernate.Transaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Books;
import model.Category;
import util.HibernateUtil;

@WebServlet("/UpdateBookServlet")
@MultipartConfig
public class UpdateBookServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    int bid = Integer.parseInt(request.getParameter("bid"));
	    String name = request.getParameter("name");
	    String author = request.getParameter("author");
	    double price = Double.parseDouble(request.getParameter("price"));

	    int cid = Integer.parseInt(request.getParameter("cid")); // ✅ FIX

	    Part part = request.getPart("image");

	    Session session = HibernateUtil.getFactory().openSession();
	    Transaction tx = session.beginTransaction();

	    Books b = session.get(Books.class, bid);
	    Category category = session.get(Category.class, cid); // ✅ FIX

	    b.setBname(name);
	    b.setBauthor(author);
	    b.setBprice(price);
	    b.setCategory(category); // ✅ FIX

	    // Image update
	    if (part != null && part.getSize() > 0) {

	        String oldImage = b.getImage();
	        if (oldImage != null) {
	            File oldFile = new File(
	                getServletContext().getRealPath("/uploads/books/")
	                + File.separator + oldImage
	            );
	            if (oldFile.exists()) oldFile.delete();
	        }

	        String fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();

	        String path = getServletContext().getRealPath("/uploads/books/");
	        File dir = new File(path);
	        if (!dir.exists()) dir.mkdirs();

	        part.write(path + File.separator + fileName);
	        b.setImage(fileName);
	    }

	    session.update(b);
	    tx.commit();
	    session.close();

	    response.sendRedirect(request.getContextPath() + "/admin/book");
	}
}