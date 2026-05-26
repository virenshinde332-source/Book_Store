<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, model.Books"%>
<%@ page import="model.Category"%>

<!DOCTYPE html>
<html>
<head>
<title>Book Store | Home</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-50">

<!-- Navbar -->
<%@ include file="/user/navbar.jsp"%>

<!-- Hero Section -->
<section class="bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-500 text-white py-24 text-center">
    <h1 class="text-5xl font-extrabold tracking-wide">
        Discover Your Next Favorite Book 📚
    </h1>
    <p class="mt-4 text-lg text-gray-200">
        Explore thousands of books across all genres
    </p>
</section>

<!-- Categories Section -->
<section class="max-w-7xl mx-auto py-14 px-6">
    <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">
        Browse Categories
    </h2>

    <div class="grid grid-cols-2 md:grid-cols-4 gap-6">

<%
List<Category> categories =
    (List<Category>) request.getAttribute("categories");

if (categories != null && !categories.isEmpty()) {
    for (Category c : categories) {
%>

        <a href="<%=request.getContextPath()%>/ProductsByCategory?cid=<%=c.getCid()%>"
           class="group bg-white shadow-md rounded-xl p-6 text-center 
                  hover:shadow-2xl hover:-translate-y-2 transition duration-300">

            <div class="text-4xl mb-3 group-hover:scale-110 transition">
                📚
            </div>

            <h3 class="font-semibold text-lg text-gray-800 group-hover:text-indigo-600">
                <%= c.getCname() %>
            </h3>

        </a>

<%
    }
} else {
%>
        <p class="text-gray-500 col-span-full text-center">
            No categories available
        </p>
<%
}
%>

    </div>
</section>

<!-- Featured Books -->
<section class="max-w-7xl mx-auto py-14 px-6">
    <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">
        Featured Books
    </h2>

    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-8">

<%
List<Books> books =
    (List<Books>) request.getAttribute("featuredBooks");

if (books != null && !books.isEmpty()) {
    for (Books b : books) {
%>

        <!-- Book Card -->
        <div class="bg-white shadow-md rounded-xl overflow-hidden 
                    hover:shadow-2xl transition duration-300 group">

            <!-- Image -->
            <div class="overflow-hidden">
                <img
                    src="<%=request.getContextPath()%>/uploads/books/<%= (b.getImage()!=null)?b.getImage():"no-book.png" %>"
                    class="h-48 w-full object-cover group-hover:scale-110 transition duration-300">
            </div>

            <!-- Content -->
            <div class="p-4">

                <h3 class="text-lg font-semibold text-gray-800 truncate">
                    <a href="<%=request.getContextPath()%>/ProductDetailsServlet?id=<%=b.getBid()%>"
                       class="hover:text-indigo-600 transition">
                        <%= b.getBname() %>
                    </a>
                </h3>

                <p class="text-gray-500 text-sm mt-1">
                    ✍️ <%= b.getBauthor() %>
                </p>

                <p class="text-indigo-600 font-bold text-lg mt-2">
                    ₹ <%= b.getBprice() %>
                </p>

                <a href="<%=request.getContextPath()%>/AddToCartServlet?bid=<%=b.getBid()%>"
                   class="mt-4 block text-center px-4 py-2 bg-indigo-600 text-white rounded-lg 
                          hover:bg-indigo-700 transition">
                    Add to Cart
                </a>

            </div>
        </div>

<%
    }
} else {
%>
        <p class="text-gray-500 text-center col-span-full">
            No featured books available 📚
        </p>
<%
}
%>

    </div>
</section>

<!-- Footer -->
<footer class="bg-white text-center py-6 text-gray-500 text-sm mt-10 shadow-inner">
    © 2026 Book Store. All rights reserved.
</footer>

</body>
</html>