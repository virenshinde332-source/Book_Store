<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Book Store | Welcome</title>

<script src="https://cdn.tailwindcss.com"></script>

<style>
    body { font-family: 'Poppins', sans-serif; }

    /* Fade animation */
    .fade-up {
        opacity: 0;
        transform: translateY(40px);
        transition: all 0.8s ease;
    }

    .fade-up.show {
        opacity: 1;
        transform: translateY(0);
    }
</style>

</head>

<body id="body" class="bg-gray-50 transition duration-500">

<!-- Navbar -->
<%@ include file="/user/navbar.jsp" %>


<!-- ================= HERO ================= -->
<section class="min-h-screen flex items-center justify-center bg-gradient-to-br from-indigo-700 via-purple-700 to-pink-600 text-white">

    <div class="max-w-6xl mx-auto px-6 grid md:grid-cols-2 gap-10 items-center">

        <!-- LEFT -->
        <div>

            <h1 class="text-5xl font-extrabold mb-4">
                Welcome to 📚 Book Store
            </h1>

            <!-- ✨ TYPING TEXT -->
            <h2 class="text-2xl text-yellow-300 font-semibold mb-6">
                <span id="typing"></span>
            </h2>

            <p class="text-lg text-gray-200 mb-8">
                Discover books, gain knowledge, and grow every day.
            </p>

            <div class="flex gap-4 flex-wrap">

                <a href="<%=request.getContextPath()%>/user/userRegister.jsp"
                   class="px-8 py-3 bg-white text-indigo-700 rounded-full font-semibold hover:scale-105 transition shadow-lg">
                    🚀 Get Started
                </a>

                <a href="<%=request.getContextPath()%>/user/userLogin.jsp"
                   class="px-8 py-3 border border-white rounded-full hover:bg-white hover:text-indigo-700 transition">
                    🔐 Login
                </a>

            </div>

        </div>

        <!-- RIGHT -->
        <div class="hidden md:block fade-up">

            <div class="bg-white/10 backdrop-blur-lg p-10 rounded-3xl shadow-2xl text-center">
                <div class="text-6xl mb-4">📖</div>

                <h3 class="text-xl font-semibold mb-2">
                    Learn Anytime
                </h3>

                <p class="text-gray-200 text-sm">
                    Read books anywhere, anytime and boost your knowledge.
                </p>
            </div>

        </div>

    </div>

</section>

<!-- FEATURES -->
<section class="max-w-7xl mx-auto py-20 px-6">

    <h2 class="text-3xl font-bold text-center mb-12 fade-up">
        Why Choose Us?
    </h2>

    <div class="grid md:grid-cols-3 gap-10 text-center">

        <div class="bg-white p-8 rounded-xl shadow hover:shadow-xl transition fade-up">
            <div class="text-4xl mb-3">📚</div>
            <h3 class="font-semibold text-lg mb-2">Huge Collection</h3>
            <p class="text-gray-500">Explore books from all categories and genres.</p>
        </div>

        <div class="bg-white p-8 rounded-xl shadow hover:shadow-xl transition fade-up">
            <div class="text-4xl mb-3">⚡</div>
            <h3 class="font-semibold text-lg mb-2">Fast Experience</h3>
            <p class="text-gray-500">Smooth browsing and quick checkout process.</p>
        </div>

        <div class="bg-white p-8 rounded-xl shadow hover:shadow-xl transition fade-up">
            <div class="text-4xl mb-3">💰</div>
            <h3 class="font-semibold text-lg mb-2">Best Prices</h3>
            <p class="text-gray-500">Affordable pricing for every reader.</p>
        </div>

    </div>
 
</section>


<!-- ================= CTA ================= -->
<section class="bg-indigo-600 text-white py-16 text-center fade-up">

    <h2 class="text-4xl font-bold mb-4">
        Start Your Reading Journey 🚀
    </h2>

    <p class="mb-6 text-gray-200">
        Join now and explore amazing books.
    </p>

    <a href="<%=request.getContextPath()%>/user/userRegister.jsp"
       class="px-8 py-3 bg-white text-indigo-700 rounded-full font-semibold hover:scale-105 transition">
        Create Account
    </a>

</section>

<!-- FOOTER -->
<footer class="bg-white dark:bg-gray-900 border-t text-center py-6 text-gray-500 text-sm">
    © 2026 Book Store
</footer>

<!-- ================= JS ================= -->
<script>

    // ✨ Typing Effect
    const words = ["Read Books ", "Gain Knowledge ", "Build Your Future"];
    let i = 0, j = 0, current = "", isDeleting = false;

    function type() {
        current = words[i];

        if (isDeleting) {
            document.getElementById("typing").textContent =
                current.substring(0, j--);
        } else {
            document.getElementById("typing").textContent =
                current.substring(0, j++);
        }

        if (!isDeleting && j === current.length) {
            isDeleting = true;
            setTimeout(type, 1000);
            return;
        }

        if (isDeleting && j === 0) {
            isDeleting = false;
            i = (i + 1) % words.length;
        }

        setTimeout(type, isDeleting ? 50 : 100);
    }

    type();

    // 🎯 Scroll Animation
    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add("show");
            }
        });
    });

    document.querySelectorAll(".fade-up").forEach(el => {
        observer.observe(el);
    });


</script>

</body>
</html>