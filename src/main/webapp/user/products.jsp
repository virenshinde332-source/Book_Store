<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Books" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Store | Books</title>

    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-50 min-h-screen flex flex-col">

<!-- Navbar -->
<%@ include file="/user/navbar.jsp" %>

<div class="max-w-7xl mx-auto px-6 py-10 flex-1">

    <!-- Heading -->
    <h2 class="text-3xl font-bold mb-8 text-gray-800 text-center">
        📚 Explore Our Books Collection
    </h2>

    <!-- Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">

<%
List<Books> books = (List<Books>) request.getAttribute("books");

if (books != null && !books.isEmpty()) {
    for (Books b : books) {
%>

        <!-- Book Card -->
        <div class="bg-white shadow-md rounded-xl overflow-hidden 
                    hover:shadow-xl transition duration-300 group">

            <!-- Image -->
            <div class="overflow-hidden">
                <img 
                    src="<%= request.getContextPath() %>/uploads/books/<%= (b.getImage()!=null && !b.getImage().isEmpty()) ? b.getImage() : "no-book.png" %>" 
                    class="w-full h-52 object-cover group-hover:scale-110 transition duration-300">
            </div>

            <div class="p-4">

                <!-- Title -->
                <h3 class="text-lg font-semibold text-gray-800 truncate">
                    <a href="<%=request.getContextPath()%>/BookDetailsServlet?id=<%=b.getBid()%>"
                       class="text-indigo-600 hover:underline">
                        <%= b.getBname() %>
                    </a>
                </h3>

                <!-- Author -->
                <p class="text-gray-500 text-sm mt-1">
                    ✍️ <%= b.getBauthor() %>
                </p>

                <!-- Price -->
                <p class="text-indigo-600 font-bold mt-2">
                    ₹ <%= b.getBprice() %>
                </p>

                <!-- Category (FIXED ✅) -->
                <p class="text-gray-500 text-sm mt-1">
                    📂 
                    <%= (b.getCategory() != null) ? b.getCategory().getCname() : "General" %>
                </p>

                <!-- Action -->
                <div class="mt-4">
                    <a href="<%=request.getContextPath()%>/AddToCartServlet?bid=<%= b.getBid() %>"
                       class="block text-center px-4 py-2 bg-indigo-600 text-white rounded hover:bg-indigo-700 transition text-sm font-semibold">
                        Add to Cart
                    </a>
                </div>

            </div>
        </div>

<%
    }
} else {
%>

        <p class="text-gray-500 col-span-full text-center text-lg">
            No books available 📚
        </p>

<%
}
%>

    </div>
</div>

<!-- Footer -->
<footer class="bg-white border-t text-center py-6 text-gray-500 text-sm">
    © 2026 Book Store. All rights reserved.
</footer>

</body>
</html>