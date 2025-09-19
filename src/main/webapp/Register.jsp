<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PortERP | Register</title>

<!-- Bootstrap CSS CDN Link -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<!-- Custom CSS for Login/Register page -->
<link rel="stylesheet" href="css/login-register.css">

</head>
<body class="login-register-page">

	<header class="header">
		<section class="flex">
			<a href="Register.jsp" class="logo"></a>

			<div class="icons">
				<div id="toggle-btn" class="fas fa-sun"></div>
			</div>
		</section>
	</header>

	<section class="h-100">
		<div class="container h-100">
			<div class="row justify-content-md-center h-100">
				<div class="card-wrapper">
					<div class="brand">
						<h1>PortERP</h1>
					</div>
					<div class="card fat">
						<div class="card-body">
							<h4 class="card-title">Register</h4>
							<form action="RegisterServlet" method="post"
								class="login-register-validation" id="registerForm" novalidate>
								<input type="hidden" name="action" value="register">

								<!-- Port ID -->
								<div class="form-group">
									<label for="portId">Port Name</label> <input id="portname"
										type="text" class="form-control" name="portname"
										placeholder="Enter your port Name" required autofocus />
									<div class="invalid-feedback">Please enter a valid Port
										Name</div>
								</div>

								<!-- Password -->
								<div class="form-group">
									<label for="password">Password</label> <input id="password"
										type="password" class="form-control" name="password"
										placeholder="Enter your password" required maxlength="20" />
									<div class="invalid-feedback">Password is required</div>
								</div>

								<!-- Confirm Password -->
								<div class="form-group">
									<label for="confirmPassword">Confirm Password</label> <input
										id="confirmPassword" type="password" class="form-control"
										name="confirmPassword" placeholder="Re-enter your password"
										required maxlength="20" oninput="checkPasswordMatch()" />
									<div class="invalid-feedback">Passwords must match</div>
								</div>

								<!-- Role Dropdown -->
								<div class="form-group">
									<label for="role">Select Role</label> <select id="role"
										class="form-control" name="role" required>
										<option value="" disabled selected>Select your role</option>
										<option value="Consumer">Consumer</option>
										<option value="Seller">Seller</option>
									</select>
									<div class="invalid-feedback">Please select a role</div>
								</div>

								<!-- Location (Visible only for Consumer) -->
								<div class="form-group" id="consumer-role"
									style="display: none;">
									<label for="location">Location</label> <input id="location"
										type="text" class="form-control" name="location"
										placeholder="Enter your location" />
									<div class="invalid-feedback">Please enter your location</div>
								</div>

								<!-- Register Button -->
								<div class="form-group m-0">
									<button type="submit" class="btn btn-primary btn-block">Register
										Now</button>
								</div>
							</form>

							<!-- Login Link -->
							<div
								class="mt-4 text-center d-flex justify-content-center align-items-center">
								<span>Already a user?</span> <a href="login.jsp" class="btn"
									style="margin-left: 0px; color: blue;">Log In</a>
							</div>


							<!-- Display message if available -->
							<%
							if (request.getAttribute("message") != null) {
							%>
							<p style="color: red; text-align: center;"><%=request.getAttribute("message")%></p>
							<%
							}
							%>
						</div>
					</div>

					<div class="footer"> &copy; Copyright 2024 - PortERP</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Bootstrap and jQuery Scripts -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>

	<!-- Custom JS to handle role selection and display location input -->
	<script>
		document.getElementById('registerForm').addEventListener('submit',
				function(event) {
					var form = this;
					var isValid = true;

					// Check if all required fields are filled
					if (!form.checkValidity()) {
						isValid = false;
					}

					// Prevent form submission if not valid
					if (!isValid) {
						event.preventDefault();
						form.classList.add('was-validated');
					}
				});

		// Handle role selection
		document.getElementById('role').addEventListener('change', function() {
			var role = this.value;
			var locationField = document.getElementById('location');
			var consumerRole = document.getElementById('consumer-role');

			if (role === 'Consumer') {
				consumerRole.style.display = 'block';
				locationField.setAttribute('required', 'required'); // Make location field required
			} else {
				consumerRole.style.display = 'none';
				locationField.removeAttribute('required'); // Remove required if not Consumer
			}
		});

		// Check password match
		function checkPasswordMatch() {
			var password = document.getElementById('password');
			var confirmPassword = document.getElementById('confirmPassword');

			if (password.value !== confirmPassword.value) {
				confirmPassword.setCustomValidity("Passwords do not match");
			} else {
				confirmPassword.setCustomValidity(''); // Clear the error
			}
		}

		// Toggle role display (duplicated logic removed)
	</script>

</body>
</html>