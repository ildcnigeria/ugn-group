const SUPABASE_URL = 'https://enkscdyeuqnedjhawtpi.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_FzSikLnXtnXnQphBW4jGDQ_1zmH_Xx0';

window.addEventListener('load', function() {
    const navLinks = document.querySelectorAll('.nav-link');
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';

    navLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href === currentPage) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });
});