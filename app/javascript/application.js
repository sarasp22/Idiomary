import "@hotwired/turbo-rails"
import "controllers"

window.onclick = function(event) {
  if (!event.target.closest('.language-dropdown')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    for (var i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

window.onclick = function(event) {
  if (!event.target.closest('.language-dropdown')) {
    var langMenus = document.querySelectorAll('.language-dropdown .dropdown-content');
    langMenus.forEach(function(menu) {
      menu.classList.remove('show');
    });
  }

  if (!event.target.closest('.user-dropdown')) {
    var userMenus = document.querySelectorAll('.user-dropdown .dropdown-content');
    userMenus.forEach(function(menu) {
      menu.classList.remove('show');
    });
  }

  if (!event.target.closest('.auth-language-dropdown')) {
    var authLangMenus = document.querySelectorAll('.auth-language-dropdown .dropdown-content');
    authLangMenus.forEach(function(menu) {
      menu.classList.remove('show');
    });
  }
}
