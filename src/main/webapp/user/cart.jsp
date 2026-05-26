<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map, model.Books" %>
<script src="https://cdn.tailwindcss.com"></script>

<!-- Navbar -->
<%@ include file="/user/navbar.jsp" %>

<div class="max-w-6xl mx-auto px-4 py-8">

    <h2 class="text-3xl font-bold mb-8">📚 Your Book Cart</h2>

<%
    Map<Integer, Integer> cartMap =
            (Map<Integer, Integer>) request.getAttribute("cart");

    Map<Integer, Books> bookMap =
            (Map<Integer, Books>) request.getAttribute("books");

    if (cartMap != null && !cartMap.isEmpty()) {

        double totalAmount = 0;
%>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

        <!-- ================= CART ITEMS ================= -->
        <div class="lg:col-span-2 space-y-4">

        <%
            for (Map.Entry<Integer, Integer> entry : cartMap.entrySet()) {

                Integer bookId = entry.getKey();
                Integer quantity = entry.getValue();

                Books book = bookMap.get(bookId);
                if (book == null) continue;

                double subTotal = book.getBprice() * quantity;
                totalAmount += subTotal;
        %>

            <div class="flex gap-4 bg-white border rounded-xl p-4 shadow-sm hover:shadow-md transition">

                <!-- Book Image -->
                <img src="<%=request.getContextPath()%>/uploads/books/<%=book.getImage()%>"
                     alt="<%=book.getBname()%>"
                     class="h-28 w-20 object-cover rounded-lg border">

                <div class="flex-1">
                    <h3 class="text-lg font-semibold mb-1">
                        <%=book.getBname()%>
                    </h3>

                    <p class="text-sm text-gray-500">
                        ✍️ <%=book.getBauthor()%>
                    </p>

                    <p class="text-sm text-gray-500 mt-1">
                        ₹ <%=book.getBprice()%> per book
                    </p>

                    <!-- Quantity Controls -->
                    <div class="flex items-center gap-2 mt-3">

                        <a href="UpdateCartServlet?bid=<%=book.getBid()%>&action=dec"
                           class="w-8 h-8 flex items-center justify-center rounded-full bg-gray-200 hover:bg-gray-300">
                            −
                        </a>

                        <span class="w-8 text-center font-medium">
                            <%=quantity%>
                        </span>

                        <a href="UpdateCartServlet?bid=<%=book.getBid()%>&action=inc"
                           class="w-8 h-8 flex items-center justify-center rounded-full bg-gray-200 hover:bg-gray-300">
                            +
                        </a>

                        <a href="UpdateCartServlet?bid=<%=book.getBid()%>&action=remove"
                           class="ml-4 text-sm text-red-600 hover:underline">
                            Remove
                        </a>
                    </div>
                </div>

                <div class="text-right text-lg font-semibold">
                    ₹ <%=subTotal%>
                </div>
            </div>

        <%
            }
        %>

        </div>

        <!-- ================= ORDER SUMMARY ================= -->
        <div class="bg-white border rounded-xl p-6 shadow-sm h-fit sticky top-24">

            <h3 class="text-xl font-semibold mb-4">Order Summary</h3>

            <div class="flex justify-between text-gray-600 mb-2">
                <span>Books Total</span>
                <span>₹ <%=totalAmount%></span>
            </div>

            <div class="flex justify-between text-gray-600 mb-2">
                <span>Delivery</span>
                <span class="text-green-600">FREE</span>
            </div>

            <hr class="my-4">

            <div class="flex justify-between text-lg font-bold mb-6">
                <span>Grand Total</span>
                <span>₹ <%=totalAmount%></span>
            </div>

            <a href="<%=request.getContextPath()%>/user/selectPayment.jsp"
               class="block text-center bg-indigo-600 hover:bg-indigo-700 text-white py-3 rounded-lg font-semibold transition">
                Proceed to Checkout
            </a>
        </div>

    </div>

<%
    } else {
%>

    <!-- ================= EMPTY CART ================= -->
    <div class="text-center py-24">
        <div class="text-5xl mb-4">📚</div>
        <p class="text-xl font-semibold mb-2">Your book cart is empty</p>
        <p class="text-gray-500">Browse books and add them to your cart</p>

        <a href="<%=request.getContextPath()%>/home"
           class="inline-block mt-6 bg-indigo-600 text-white px-6 py-2 rounded-lg hover:bg-indigo-700">
            Explore Books
        </a>
    </div>

<%
    }
%>

</div>