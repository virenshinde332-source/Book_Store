<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Books"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Books</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 min-h-screen">

<!-- NAVBAR -->
<%@ include file="admin-navbar.jsp"%>

<div class="max-w-6xl mx-auto px-4 py-8">

	<h2 class="text-3xl font-bold mb-6">📚 Available Books</h2>

	<div class="overflow-x-auto">
		<table class="min-w-full bg-white rounded-lg shadow overflow-hidden">

			<thead class="bg-gray-200 text-gray-700">
				<tr>
					<th class="py-3 px-4 text-left">Title</th>
					<th class="py-3 px-4 text-left">Author</th>
					<th class="py-3 px-4 text-left">Price</th>
					<th class="py-3 px-4 text-left">Category</th>
					<th class="py-3 px-4 text-left">Cover</th>
					<th class="py-3 px-4 text-left">Action</th>
				</tr>
			</thead>

			<tbody class="divide-y divide-gray-200">

<%
List<Books> books = (List<Books>) request.getAttribute("books");

if (books != null && !books.isEmpty()) {
	for (Books b : books) {
%>

				<tr class="hover:bg-gray-50">

					<td class="py-3 px-4"><%= b.getBname() %></td>
					<td class="py-3 px-4"><%= b.getBauthor() %></td>
					<td class="py-3 px-4">₹ <%= b.getBprice() %></td>
					<td class="py-3 px-4"><%= b.getCategory().getCname() %></td>

					<td class="py-3 px-4">
						<%
						if (b.getImage() != null && !b.getImage().isEmpty()) {
						%>
							<img src="<%=request.getContextPath()%>/uploads/books/<%= b.getImage() %>"
							     class="h-20 w-16 object-cover rounded">
						<%
						} else {
						%>
							<span class="text-gray-500">No Image</span>
						<%
						}
						%>
					</td>

					<td class="py-3 px-4 space-x-2">

						<a href="<%=request.getContextPath()%>/EditBookServlet?id=<%=b.getBid()%>"
						   class="px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700">
							Edit
						</a>

						<a href="<%=request.getContextPath()%>/DeleteBookServlet?bid=<%=b.getBid()%>"
						   onclick="return confirm('Delete this book?');"
						   class="px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700">
							Delete
						</a>

					</td>

				</tr>

<%
	}
} else {
%>

				<tr>
					<td colspan="6" class="py-6 text-center text-gray-500">
						No books available 📚
					</td>
				</tr>

<%
}
%>

			</tbody>
		</table>
	</div>

	<div class="mt-6">
		<a href="<%=request.getContextPath()%>/LoadAddProductServlet"
		   class="px-6 py-3 bg-indigo-600 text-white rounded hover:bg-indigo-700">
			Add New Book
		</a>
	</div>

</div>

</body>
</html>