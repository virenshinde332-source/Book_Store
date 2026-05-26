<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Category" %>

<%
    List<Category> categories =
        (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 min-h-screen">

<!-- NAVBAR -->
<%@ include file="admin-navbar.jsp" %>

<div class="max-w-3xl mx-auto px-4 py-8">

    <h2 class="text-3xl font-bold mb-6">Add New Book 📚</h2>

    <form action="<%= request.getContextPath() %>/AddBookServlet"
          method="post"
          enctype="multipart/form-data"
          
          class="bg-white p-6 rounded-xl shadow-md space-y-4">

        <!-- Book Name -->
        <div>
            <label class="block font-semibold mb-1">Book Title</label>
            <input type="text"
                   name="name"
                   required
                   placeholder="Enter book title"
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-indigo-500">
        </div>

        <!-- Author -->
        <div>
            <label class="block font-semibold mb-1">Author</label>
            <input type="text"
                   name="author"
                   required
                   placeholder="Enter author name"
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-indigo-500">
        </div>

        <!-- Price -->
        <div>
            <label class="block font-semibold mb-1">Price (₹)</label>
            <input type="number"
                   step="0.01"
                   name="price"
                   required
                   placeholder="Enter price"
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-indigo-500">
        </div>

 <!-- Category -->
        <div>
            <label class="block font-semibold mb-1">Category</label>
            <select name="cid"
                    required
                    class="w-full border border-gray-300 rounded px-3 py-2
                           focus:outline-none focus:ring-2 focus:ring-green-500">
                <option value="">-- Select Category --</option>
                <%
                    if (categories != null) {
                        for (Category c : categories) {
                %>
                    <option value="<%= c.getCid() %>">
                        <%= c.getCname() %>
                    </option>
                <%
                        }
                    }
                %>
            </select>
        </div>
        <!-- Image Upload -->
        <div>
            <label class="block font-semibold mb-1">Book Cover</label>
            <input type="file"
                   name="image"
                   required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-indigo-500">
        </div>

        <!-- Submit -->
        <div>
            <button type="submit"
                    class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-3 rounded-lg transition">
                Add Book
            </button>
        </div>

    </form>

</div>

</body>
</html>