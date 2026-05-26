<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us | Apna Book Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100">

    <!-- Navbar -->
    <%@ include file="/user/navbar.jsp" %> 

    <!-- About Section -->
    <section class="bg-white py-12 px-6 md:px-16 lg:px-24">
        <div class="max-w-6xl mx-auto">

            <h1 class="text-3xl font-bold text-gray-800 mb-6">
                About Apna Book Store
            </h1>

            <p class="text-gray-600 leading-relaxed mb-5">
                Welcome to <span class="font-semibold text-blue-600">Apna Book Store</span>,
                your one-stop destination for books across all genres. From academic
                textbooks to novels, self-help, and competitive exam guides, we bring
                knowledge and stories closer to you.
            </p>

            <p class="text-gray-600 leading-relaxed mb-5">
                Inspired by traditional bookstores, Apna Book Store combines the
                charm of browsing books with the convenience of online shopping.
                We ensure that every book is authentic, affordable, and easily accessible.
            </p>

            <p class="text-gray-600 leading-relaxed mb-8">
                Whether you are a student, a reader, or a knowledge seeker,
                we are committed to providing a smooth and enriching book
                shopping experience.
            </p>

            <!-- Highlights -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

                <div class="border rounded-lg p-6 text-center">
                    <h3 class="text-lg font-semibold text-gray-800 mb-2">
                        📚 Wide Collection
                    </h3>
                    <p class="text-gray-600 text-sm">
                        Explore books from various genres including academics,
                        fiction, non-fiction, and more.
                    </p>
                </div>

                <div class="border rounded-lg p-6 text-center">
                    <h3 class="text-lg font-semibold text-gray-800 mb-2">
                        🛒 Easy Ordering
                    </h3>
                    <p class="text-gray-600 text-sm">
                        Simple interface with quick search and smooth
                        checkout experience.
                    </p>
                </div>

                <div class="border rounded-lg p-6 text-center">
                    <h3 class="text-lg font-semibold text-gray-800 mb-2">
                        🚚 Fast Delivery
                    </h3>
                    <p class="text-gray-600 text-sm">
                        Reliable and timely delivery to ensure your books
                        reach you quickly.
                    </p>
                </div>

            </div>

        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-900 text-gray-300 text-center py-4 mt-12">
        <p class="text-sm">
            © 2026 Apna Book Store. All rights reserved.
        </p>
    </footer>

</body>
</html>