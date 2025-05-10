document.addEventListener('DOMContentLoaded', function () {
  const toggleButton = document.getElementById('menu-toggle');
  const mobileMenu = document.getElementById('mobile-menu');
  const overlay = document.getElementById('overlay');
  const menuLinks = document.querySelectorAll('.mobile-menu-link');

  function openMenu() {
    mobileMenu.classList.remove('translate-x-full');
    overlay.classList.remove('hidden');
  }

  function closeMenu() {
    mobileMenu.classList.add('translate-x-full');
    overlay.classList.add('hidden');
  }

  if (toggleButton) {
    toggleButton.addEventListener('click', () => {
      if (mobileMenu.classList.contains('translate-x-full')) {
        openMenu();
      } else {
        closeMenu();
      }
    });
  }

  if (overlay) {
    overlay.addEventListener('click', closeMenu);
  }

  menuLinks.forEach(link => {
    link.addEventListener('click', closeMenu);
  });
});
