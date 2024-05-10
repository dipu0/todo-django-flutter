document.addEventListener('DOMContentLoaded', function() {

    // Basic Form Validation Example
    const loginForm = document.querySelector('#loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            const username = document.querySelector('#username').value;
            const password = document.querySelector('#password').value;

            if (!username || !password) {
                alert('Please fill in all fields.');
                e.preventDefault(); // Prevent form submission
            }
        });
    }

    // Add other common functionalities as needed

});
