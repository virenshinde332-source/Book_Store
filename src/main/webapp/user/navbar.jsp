<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="model.User"%>

<%
User user = (User) session.getAttribute("user");
%>

<%
int cartCount = 0;

Map<Integer, Integer> cart =
        (Map<Integer, Integer>) session.getAttribute("cart");

if (cart != null) {
    cartCount = cart.size();
}
%>

<nav
	class="flex items-center justify-between px-16 py-4 
            bg-white/80 backdrop-blur-lg shadow-md border-b sticky top-0 z-50">

	<!-- Logo -->
	<a href="<%=request.getContextPath()%>/index.jsp"
		class="flex items-center gap-3 group"> <!-- Icon -->
		<div
			class="text-3xl transition transform group-hover:rotate-6 group-hover:scale-110">
			📚</div> <!-- Text -->
		<div class="flex flex-col leading-tight">
			<span
				class="text-2xl font-extrabold 
                     bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-500 
                     text-transparent bg-clip-text tracking-wide">
				BookStore </span> <span
				class="text-[10px] text-gray-400 tracking-widest uppercase">
				Read • Learn • Grow </span>
		</div>

	</a>
	<!-- Center Menu -->
	<div class="flex items-center gap-8">

		<a href="<%=request.getContextPath()%>/home"
			class="relative font-medium text-gray-700 hover:text-indigo-600 transition group">
			Home <span
			class="absolute left-0 -bottom-1 w-0 h-[2px] bg-indigo-600 transition-all group-hover:w-full"></span>
		</a> <a href="<%=request.getContextPath()%>/user/about.jsp"
			class="relative font-medium text-gray-700 hover:text-indigo-600 transition group">
			About <span
			class="absolute left-0 -bottom-1 w-0 h-[2px] bg-indigo-600 transition-all group-hover:w-full"></span>
		</a> <a href="<%=request.getContextPath()%>/user/contact.jsp"
			class="relative font-medium text-gray-700 hover:text-indigo-600 transition group">
			Contact <span
			class="absolute left-0 -bottom-1 w-0 h-[2px] bg-indigo-600 transition-all group-hover:w-full"></span>
		</a>

		<!-- Search -->
		<form action="<%=request.getContextPath()%>/SearchServlet"
			method="get"
			class="flex items-center gap-2 px-4 py-2 rounded-full 
                     bg-gray-100 focus-within:ring-2 focus-within:ring-indigo-400 transition">

			<input name="q" class="bg-transparent outline-none text-sm w-40"
				placeholder="Search books..."> <span class="text-gray-500">🔍</span>
		</form>
	</div>

	<!-- Right Side -->
	<div class="flex items-center gap-6">

		<!-- Cart -->
		<a href="<%=request.getContextPath()%>/ViewCartServlet"
			class="relative text-2xl hover:text-indigo-600 transition transform hover:scale-110">

			🛒 <% if (cartCount > 0) { %> <span
			class="absolute -top-2 -right-3 text-xs bg-gradient-to-r 
                           from-red-500 to-pink-500 text-white w-[20px] h-[20px] 
                           rounded-full flex items-center justify-center 
                           animate-pulse shadow">
				<%= cartCount %>
		</span> <% } %>
		</a>

		<!-- User Dropdown -->
		<div class="relative">

			<!-- User Button -->
			<button onclick="toggleUserMenu()"
				class="flex items-center gap-2 px-3 py-1.5 rounded-full 
                           hover:bg-gray-100 transition">

				<span class="text-xl">👤</span>

				<% if(user != null){ %>
				<span class="font-medium text-sm text-gray-700"> <%= user.getName() %>
				</span>
				<% } %>

			</button>

			<!-- Dropdown -->
			<div id="userMenu"
				class="hidden absolute right-0 mt-3 w-48 bg-white border 
                        rounded-xl shadow-xl overflow-hidden animate-fade-in">

				<%
                if (session.getAttribute("user") == null) {
                %>

				<a href="<%=request.getContextPath()%>/user/userLogin.jsp"
					class="block px-4 py-2 hover:bg-indigo-50 transition"> Login </a> <a
					href="<%=request.getContextPath()%>/user/userRegister.jsp"
					class="block px-4 py-2 hover:bg-indigo-50 transition"> Register
				</a>

				<%
                } else {
                %>

				<a href="<%=request.getContextPath()%>/user/profile.jsp"
					class="block px-4 py-2 hover:bg-indigo-50 transition"> Profile
				</a> <a href="<%=request.getContextPath()%>/UserOrdersServlet"
					class="block px-4 py-2 hover:bg-indigo-50 transition"> Orders </a>

				<a href="<%=request.getContextPath()%>/UserLogoutServlet"
					class="block px-4 py-2 text-red-600 hover:bg-red-50 transition">
					Logout </a>

				<%
                }
                %>

			</div>

		</div>

	</div>
</nav>

<script>
function toggleUserMenu() {
    const menu = document.getElementById("userMenu");
    menu.classList.toggle("hidden");
}
</script>