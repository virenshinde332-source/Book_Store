<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Books, model.Category"%>

<%
Books book = (Books) request.getAttribute("book");

if (book == null) {
%>
<div class="max-w-2xl mx-auto mt-20 text-center text-red-600 text-xl font-semibold">
    Book not found
</div>
<%
    return;
}

List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Book</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 min-h-screen">

<!-- NAVBAR -->
<%@ include file="admin-navbar.jsp"%>

<div class="max-w-3xl mx-auto px-4 py-8">

    <h2 class="text-3xl font-bold mb-6">Edit Book 📚</h2>

    <form action="<%=request.getContextPath()%>/EditBookServlet"
          method="post"
          enctype="multipart/form-data"
          class="bg-white p-6 rounded-xl shadow-md space-y-4">

        <input type="hidden" name="bid" value="<%= book.getBid() %>">

        <!-- Book Title -->
        <div>
            <label class="block font-semibold mb-1">Book Title:</label>
            <input type="text"
                   name="name"
                   value="<%= book.getBname() %>"
                   required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-indigo-500">
        </div>

        <!-- Author -->
        <div>
            <label class="block font-semibold mb-1">Author:</label>
            <input type="text"
                   name="author"
                   value="<%= book.getBauthor() %>"
                   required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-indigo-500">
        </div>

        <!-- Price -->
        <div>
            <label class="block font-semibold mb-1">Price (₹):</label>
            <input type="number"
                   step="0.01"
                   name="price"
                   value="<%= book.getBprice() %>"
                   required
                   class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-indigo-500">
        </div>

        <!-- Category -->
        <div>
            <label class="block font-semibold mb-1">Category:</label>
            <select name="cid"
                    required
                    class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-indigo-500">

                <%
                if (categories != null) {
                    for (Category c : categories) {
                %>
                    <option value="<%= c.getCid() %>"
                        <%= (book.getCategory() != null && book.getCategory().getCid() == c.getCid()) ? "selected" : "" %>>
                        <%= c.getCname() %>
                    </option>
                <%
                    }
                }
                %>

            </select>
        </div>

        <!-- Current Image -->
        <div>
            <label class="block font-semibold mb-1">Current Cover:</label>

            <%
            if (book.getImage() != null && !book.getImage().isEmpty()) {
            %>
                <img src="<%=request.getContextPath()%>/uploads/books/<%= book.getImage() %>"
                     class="h-24 w-20 object-cover rounded border">
            <%
            } else {
            %>
                <span class="text-gray-500">No Image</span>
            <%
            }
            %>
        </div>

        <!-- Upload New Image -->
        <div>
            <label class="block font-semibold mb-1">Upload New Cover:</label>
            <input type="file"
                   name="image"
                   class="border border-gray-300 rounded px-3 py-2 w-full focus:ring-2 focus:ring-indigo-500">
        </div>

        <!-- Submit -->
        <div>
            <button type="submit"
                    class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-3 rounded-lg transition">
                Update Book
            </button>
        </div>

    </form>

</div>

</body>
</html>