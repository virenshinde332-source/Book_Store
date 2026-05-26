<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, model.Books" %>

<head>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<div class="max-w-7xl mx-auto px-6 py-10">

    <!-- Heading -->
    <h2 class="text-3xl font-bold text-gray-800 mb-8">
        🔍 Search results for 
        <span class="text-indigo-600">
            "<%=request.getAttribute("keyword")%>"
        </span>
    </h2>

<%
    List<Books> books =
        (List<Books>) request.getAttribute("books"); // keep same attribute if servlet not changed

    if (books != null && !books.isEmpty()) {
%>

    <!-- Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">

        <% for (Books b : books) { %>

        <!-- Book Card -->
        <div class="bg-white rounded-xl shadow-md hover:shadow-2xl transition overflow-hidden">

            <!-- Image -->
            <img 
                src="<%=request.getContextPath()%>/uploads/books/<%= (b.getImage()!=null)?b.getImage():"no-book.png" %>"
                class="h-52 w-full object-cover">

            <div class="p-4">

                <!-- Title -->
                <h3 class="font-semibold text-gray-800">
                    <a href="<%=request.getContextPath()%>/ProductDetailsServlet?id=<%=b.getBid()%>"
                       class="hover:text-indigo-600">
                        <%= b.getBname() %>
                    </a>
                </h3>

                <!-- Author -->
                <p class="text-sm text-gray-500 mt-1">
                    ✍️ <%= b.getBauthor() %>
                </p>

                <!-- Price -->
                <p class="text-indigo-600 font-bold mt-2">
                    ₹ <%= b.getBprice() %>
                </p>

                <!-- Action -->
                <a href="<%=request.getContextPath()%>/AddToCartServlet?bid=<%=b.getBid()%>"
                   class="block mt-4 text-center bg-indigo-600 text-white py-2 rounded-lg hover:bg-indigo-700 transition">
                   Add to Cart
                </a>

            </div>
        </div>

        <% } %>

    </div>

<%
    } else {
%>

    <!-- Empty State -->
    <div class="text-center py-20">

        <div class="text-5xl mb-4">📚</div>

        <p class="text-xl font-semibold text-gray-700 mb-2">
            No books found
        </p>

        <p class="text-gray-500 mb-6">
            Try searching with a different keyword
        </p>

        <a href="<%=request.getContextPath()%>/home"
           class="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">
            Browse Books
        </a>

    </div>

<%
    }
%>

</div>