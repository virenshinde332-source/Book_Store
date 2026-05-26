<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Books"%>

<head>
<meta charset="UTF-8">
<title>Book Details</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<%@ include file="/user/navbar.jsp"%>

<%
Books b = (Books) request.getAttribute("book");
String context = request.getContextPath();
%>

<div class="bg-gray-100 min-h-screen p-6">

	<div class="max-w-6xl mx-auto">

		<!-- Header -->
		<div class="flex justify-between items-center mb-6">

			<h2 class="text-2xl font-bold text-gray-800">📚 Book Details</h2>

			<a href="<%=request.getContextPath()%>/home"
				class="text-indigo-600 hover:underline text-sm"> ← Back to Books
			</a>

		</div>

		<div class="bg-white rounded-lg shadow p-8">

			<%
			if (b != null) {
			%>

			<div class="grid md:grid-cols-2 gap-12">

				<!-- Book Image -->
				<div class="flex justify-center">

					<img
						src="<%=(b.getImage() != null && !b.getImage().isEmpty())
		? context + "/uploads/books/" + b.getImage()
		: "https://via.placeholder.com/350"%>"
						alt="<%=b.getBname()%>"
						class="w-80 h-80 object-cover rounded-lg border shadow
hover:scale-105 transition duration-300">

				</div>

				<!-- Book Info -->
				<div>

					<h3 class="text-3xl font-bold text-gray-800 mb-2">
						<%=b.getBname()%>
					</h3>

					<p class="text-gray-500 mb-4">
						✍️
						<%=b.getBauthor()%>
					</p>

					<p class="text-3xl font-bold text-indigo-600 mb-4">
						₹
						<%=b.getBprice()%>
					</p>

					<!-- Category -->
					<p class="text-sm text-gray-500 mb-4">
						📂 Category:
						<%= (b.getCategory() != null) ? b.getCategory().getCname() : "General" %>
					</p>

					<!-- Stock -->
					<span
						class="inline-block px-3 py-1 text-xs rounded-full
bg-green-100 text-green-700 mb-6">
						Available </span>

					<!-- Quantity -->
					<div class="flex items-center gap-4 mb-6">

						<span class="text-gray-700 font-medium"> Quantity: </span>

						<div class="flex border rounded overflow-hidden">

							<button type="button" onclick="decreaseQty()"
								class="px-4 py-2 bg-gray-100 hover:bg-gray-200">-</button>

							<input id="qty" type="number" value="1" min="1"
								class="w-14 text-center outline-none">

							<button type="button" onclick="increaseQty()"
								class="px-4 py-2 bg-gray-100 hover:bg-gray-200">+</button>

						</div>

					</div>

					<!-- Buttons -->
					<div class="flex gap-4">

						<a id="cartLink"
							href="<%=context%>/AddToCartServlet?bid=<%=b.getBid()%>&qty=1"
							class="px-6 py-3 bg-indigo-600 text-white rounded-lg
shadow hover:bg-indigo-700 transition">

							🛒 Add to Cart </a> <a href="<%=request.getContextPath()%>/home"
							class="px-6 py-3 border border-gray-300 rounded-lg
hover:bg-gray-100 transition">

							Continue Browsing </a>

					</div>

				</div>

			</div>

			<%
			} else {
			%>

			<!-- Book Not Found -->
			<div class="text-center py-16">

				<div class="text-5xl mb-4">📚</div>

				<h3 class="text-xl font-semibold text-gray-700 mb-2">Book Not
					Found</h3>

				<p class="text-gray-500 mb-6">The book you are looking for does
					not exist.</p>

				<a href="<%=context%>/home"
					class="px-6 py-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">
					Browse Books </a>

			</div>

			<%
			}
			%>

		</div>
	</div>
</div>

<!-- Quantity Script -->
<script>

document.addEventListener("DOMContentLoaded", function () {

    const qtyInput = document.getElementById("qty");
    const cartLink = document.getElementById("cartLink");

    const baseUrl = "<%=context%>/AddToCartServlet?bid=<%= (b!=null)?b.getBid():0 %>&qty=";

    function updateLink(){
        let qty = parseInt(qtyInput.value);

        if(isNaN(qty) || qty < 1){
            qty = 1;
            qtyInput.value = 1;
        }

        cartLink.href = baseUrl + qty;
    }

    window.increaseQty = function(){
        let val = parseInt(qtyInput.value) || 1;
        qtyInput.value = val + 1;
        updateLink();
    }

    window.decreaseQty = function(){
        let val = parseInt(qtyInput.value) || 1;

        if(val > 1){
            qtyInput.value = val - 1;
        }

        updateLink();
    }

    qtyInput.addEventListener("input", updateLink);

});

</script>