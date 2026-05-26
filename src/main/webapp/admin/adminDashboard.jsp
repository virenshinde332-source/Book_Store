<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
    // Check admin session
    if (session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/user/userLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Book Store</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 min-h-screen">

    <!-- NAVBAR -->
    <%@ include file="admin-navbar.jsp" %>

    <div class="max-w-6xl mx-auto px-4 py-8">

        <!-- Title -->
        <h2 class="text-3xl font-bold mb-8 text-gray-800 text-center">
            📚 Admin Dashboard
        </h2>

        <!-- Cards -->
       <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">

    <!-- View Books -->
    <a href="<%= request.getContextPath() %>/ViewBookServlet"
       class="block p-6 bg-white rounded-xl shadow hover:shadow-lg transition text-center">
        <h3 class="text-lg font-semibold mb-2">📖 View Books</h3>
        <p class="text-gray-500">Browse all books in store</p>
    </a>

    <!-- Add Book -->
    <a href="<%= request.getContextPath() %>/LoadAddProductServlet"
       class="block p-6 bg-white rounded-xl shadow hover:shadow-lg transition text-center">
        <h3 class="text-lg font-semibold mb-2">➕ Add New Book</h3>
        <p class="text-gray-500">Insert new books into catalog</p>
    </a>

    <!-- View Categories -->
    <a href="<%= request.getContextPath() %>/ViewCategoryServlet"
       class="block p-6 bg-white rounded-xl shadow hover:shadow-lg transition text-center">
        <h3 class="text-lg font-semibold mb-2">📂 View Categories</h3>
        <p class="text-gray-500">Manage all categories</p>
    </a>

    <!-- Add Category -->
    <a href="<%= request.getContextPath() %>/AddCategoryServlet"
       class="block p-6 bg-white rounded-xl shadow hover:shadow-lg transition text-center">
        <h3 class="text-lg font-semibold mb-2">➕ Add Category</h3>
        <p class="text-gray-500">Create new category</p>
    </a>

    <!-- Orders -->
    <a href="<%= request.getContextPath() %>/ViewOrdersServlet"
       class="block p-6 bg-white rounded-xl shadow hover:shadow-lg transition text-center">
        <h3 class="text-lg font-semibold mb-2">📦 Orders</h3>
        <p class="text-gray-500">Manage customer orders</p>
    </a>

    <!-- Dashboard Stats (Optional future) -->
            <div class="block p-6 bg-indigo-600 text-white rounded-xl shadow text-center">
                <h3 class="text-lg font-semibold mb-2">📊 Analytics</h3>
                <p class="text-sm">Coming soon...</p>
            </div>

</div>

    </div>

</body>
</html>