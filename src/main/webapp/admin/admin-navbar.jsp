<%@ page contentType="text/html; charset=UTF-8" %>

<nav class="bg-white border-b shadow-sm">
    <div class="max-w-7xl mx-auto px-6">

        <div class="flex justify-between items-center h-16">

            <!-- Logo -->
            <div class="flex items-center space-x-3">
                <span class="text-xl font-bold text-indigo-600">
                    📚 Admin Panel
                </span>
            </div>

            <!-- Menu -->
            <div class="hidden md:flex space-x-6 font-medium text-gray-700">

                <a href="<%=request.getContextPath()%>/admin/adminDashboard.jsp"
                   class="hover:text-indigo-600 transition">
                    Dashboard
                </a>

            </div>

            <!-- Right Side -->
            <div class="flex items-center space-x-4">

                <!-- Admin Name -->
                <span class="hidden sm:block text-gray-600 font-medium">
                    👨‍💼 Admin
                </span>

                <!-- Logout -->
                <a href="<%= request.getContextPath() %>/AdminLogoutServlet"
                   class="bg-red-500 hover:bg-red-600
                          text-white px-4 py-2 rounded-lg
                          text-sm font-semibold transition">
                    Logout
                </a>

            </div>

        </div>
    </div>
</nav>