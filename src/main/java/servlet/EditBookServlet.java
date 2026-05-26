package servlet;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Books;
import model.Category;
import util.HibernateUtil;

@WebServlet("/EditBookServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class EditBookServlet extends HttpServlet {

    // 📌 LOAD BOOK (GET)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bid = Integer.parseInt(request.getParameter("id"));

        Session session = HibernateUtil.getFactory().openSession();

        Books book = session.get(Books.class, bid);
       
        Query<Category> q = session.createQuery("from Category", Category.class);
        List<Category> categories = q.list();
        
        session.close();
        
        request.setAttribute("book", book);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/editbook.jsp")
               .forward(request, response);
    }

    // 📌 UPDATE BOOK (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bid = Integer.parseInt(request.getParameter("bid"));
        String name = request.getParameter("name");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
  
        int cid = Integer.parseInt(request.getParameter("cid")); // 

        Part imagePart = request.getPart("image");

        Session session = HibernateUtil.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        Books book = session.get(Books.class, bid);
        Category category = session.get(Category.class, cid); // 

        // Update fields
        book.setBname(name);
        book.setBauthor(author);
        book.setBprice(price);
        book.setCategory(category); // 

        // IMAGE UPDATE
        if (imagePart != null && imagePart.getSize() > 0) {

            String oldImage = book.getImage();
            if (oldImage != null && !oldImage.isEmpty()) {
                String oldPath = getServletContext()
                        .getRealPath("/uploads/books/") + File.separator + oldImage;

                File oldFile = new File(oldPath);
                if (oldFile.exists()) oldFile.delete();
            }

            String fileName = System.currentTimeMillis() + "_"
                    + imagePart.getSubmittedFileName();

            String uploadPath = getServletContext()
                    .getRealPath("/uploads/books/");

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            imagePart.write(uploadPath + File.separator + fileName);

            book.setImage(fileName);
        }

        session.update(book);
        tx.commit();
        session.close();

        response.sendRedirect(request.getContextPath() + "/ViewBookServlet");
    }
}