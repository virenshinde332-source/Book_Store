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

@WebServlet("/AddBookServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class AddBookServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String name = request.getParameter("name");
	    String author = request.getParameter("author");
	    double price = Double.parseDouble(request.getParameter("price"));

	    int cid = Integer.parseInt(request.getParameter("cid")); // 

	    // Image upload
	    Part part = request.getPart("image");
	    String fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();

	    String uploadPath = getServletContext().getRealPath("/uploads/books/");
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) uploadDir.mkdirs();

	    part.write(uploadPath + File.separator + fileName);

	    // Hibernate
	    Session session = HibernateUtil.getFactory().openSession();
	    Transaction tx = session.beginTransaction();

	    Category category = session.get(Category.class, cid); //

	    Books b = new Books();
	    b.setBname(name);
	    b.setBauthor(author);
	    b.setBprice(price);
	    b.setCategory(category); //
	    b.setImage(fileName);

	    session.save(b);

	    tx.commit();
	    session.close();

	    response.sendRedirect("ViewBookServlet");
	}
	}