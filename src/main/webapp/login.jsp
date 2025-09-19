<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PortERP | Login Page</title>

<!-- Bootstrap CSS CDN Link -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<!-- Link to your custom login-register styles -->
<link rel="stylesheet" type="text/css" href="css/login-register.css">

<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

.login-register-page {
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #f7f9fb;
	height: 100vh;
}

.card-wrapper {
	width: 100%;
	max-width: 400px;
	padding: 20px;
	box-sizing: border-box;
}

.card {
	border: none;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

.brand {
	text-align: center;
	margin-bottom: 20px;
}

.footer {
	margin-top: 20px;
	padding: 10px;
	text-align: center;
	color: #888;
}

.error-message {
	color: red;
	text-align: center;
	margin-top: 10px;
}

/* For smaller screens */
@media ( max-width : 768px) {
	.card-wrapper {
		padding: 10px;
	}
}
</style>
</head>

<body class="login-register-page">

	<section class="h-100">
		<div class="container h-100">
			<div class="row justify-content-md-center h-100">
				<div class="card-wrapper">
					<div class="brand">
						<h1>PortERP</h1>
					</div>
					<div class="card fat">
						<div class="card-body">

							<h4 class="card-title">Login</h4>

							<form method="post" action="LoginServlet"
								class="login-register-validation" id="loginForm" novalidate="">
								<!-- Port ID -->
								<div class="form-group">
									<label for="portId">Port Name</label> <input id="portname"
										type="text" class="form-control" name="portname"
										placeholder="Enter your Port Name" min="0" required autofocus>
									<div class="invalid-feedback">Please enter a valid Port
										Name</div>
								</div>

								<!-- Password -->
								<div class="form-group">
									<label for="password">Password</label> <input id="password"
										type="password" class="form-control" name="password"
										placeholder="Enter your password" required>
									<div class="invalid-feedback">Password is required</div>
								</div>

								<!-- Role -->
								<div class="form-group">
									<label for="role">Role</label> <select id="role" name="role"
										class="form-control" required>
										<option value="" disabled selected>Select Role</option>
										<option value="Consumer">Consumer</option>
										<option value="Seller">Seller</option>
									</select>
									<div class="invalid-feedback">Role is required</div>
								</div>

								<!-- Submit Button -->
								<div class="form-group m-0">
									<button type="submit" class="btn btn-primary btn-block">Login</button>
								</div>

								<!-- Register Link -->
								<div class="mt-4 text-center">
									Don't have an account? <a href="Register.jsp">Sign up</a>
								</div>
							</form>

							<!-- Display error message if available -->
							<%
							if (request.getAttribute("message") != null) {
							%>
							<p class="error-message"><%=request.getAttribute("message")%></p>
							<%
							}
							%>


						</div>
					</div>
					<div class="footer">&copy; Copyright 2024 - PortERP</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Bootstrap and jQuery Scripts -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>

	<script>
		// Form validation on submit
		document.getElementById('loginForm').addEventListener('submit',
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
	</script>

</body>
</html>