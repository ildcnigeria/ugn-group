document.addEventListener('DOMContentLoaded', function() {
    const slides = document.querySelectorAll('.carousel-slide');
    const dotsContainer = document.querySelector('.carousel-dots');
    let currentSlide = 0;
    let slideInterval;

    if (slides.length === 0) return;

    function showSlide(index) {
        slides.forEach((slide, i) => {
            slide.classList.remove('active');
        });
        slides[index].classList.add('active');
        updateDots(index);
    }

    function nextSlide() {
        currentSlide = (currentSlide + 1) % slides.length;
        showSlide(currentSlide);
    }

    function prevSlide() {
        currentSlide = (currentSlide - 1 + slides.length) % slides.length;
        showSlide(currentSlide);
    }

    function createDots() {
        slides.forEach((_, index) => {
            const dot = document.createElement('div');
            dot.classList.add('carousel-dot');
            if (index === 0) dot.classList.add('active');
            dot.addEventListener('click', () => {
                currentSlide = index;
                showSlide(currentSlide);
                resetInterval();
            });
            dotsContainer.appendChild(dot);
        });
    }

    function updateDots(index) {
        const dots = document.querySelectorAll('.carousel-dot');
        dots.forEach((dot, i) => {
            dot.classList.toggle('active', i === index);
        });
    }

    function startInterval() {
        slideInterval = setInterval(nextSlide, 4000);
    }

    function resetInterval() {
        clearInterval(slideInterval);
        startInterval();
    }

    if (dotsContainer) {
        createDots();
    }

    showSlide(0);
    startInterval();

    document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowLeft') {
            prevSlide();
            resetInterval();
        } else if (e.key === 'ArrowRight') {
            nextSlide();
            resetInterval();
        }
    });
});