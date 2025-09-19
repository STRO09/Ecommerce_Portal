<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
<%
session = request.getSession(false); // Get the existing session, do not create a new one
if (session == null || session.getAttribute("userId") == null) {
	response.sendRedirect("login.jsp"); // Redirect if no session exists
	return;
}
int userId = (int) session.getAttribute("userId");
String location = (String) session.getAttribute("location");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Consumer Profile | PortERP</title>

<!-- Bootstrap, Font Awesome, and Custom CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
<link href="css/styles.css" rel="stylesheet" />

<style>
/* Additional Styles */
.container {
	margin-bottom: 20px;
	padding: 15px;
	background-color: #f9f9f9;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.container label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
	color: #333;
}

.container input[type="text"], .container input[type="password"] {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	transition: border-color 0.3s ease;
}

.container input[type="text"]:focus, .container input[type="password"]:focus
	{
	border-color: #66afe9;
	outline: none;
}

.error-message {
	color: red;
	font-size: 0.9em;
	margin-top: 5px;
}

.container input[type="submit"] {
	background-color: #4CAF50;
	color: white;
	padding: 10px 15px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.container input[type="submit"]:hover {
	background-color: #45a049;
}
</style>

<script>
	function validatePasswords() {
		var newpassword = document.getElementById("newPassword").value;
		var confirmPassword = document.getElementById("confirmPassword").value;
		if (newpassword !== confirmPassword) {
			document.getElementById("passwordError").style.display = "block";
		} else {
			document.getElementById("passwordError").style.display = "none";
		}
	}
</script>
</head>

<body class="sb-nav-fixed">
	<!-- Navigation Bar -->
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<a class="navbar-brand ps-3"
			href="<%=request.getContextPath()%>/consumer_dashboard.jsp"><center>PortERP</center></a>
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
			id="sidebarToggle">
			<i class="fas fa-bars"></i>
		</button>

		<!-- Navbar User Options -->
		<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
				role="button" data-bs-toggle="dropdown" aria-expanded="false"> <i
					class="fas fa-user fa-fw"></i>
			</a>
				<ul class="dropdown-menu dropdown-menu-end"
					aria-labelledby="navbarDropdown">
					<li><a class="dropdown-item"
						href="<%=request.getContextPath()%>/LogoutServlet">Logout</a></li>
				</ul></li>
		</ul>
	</nav>

	<!-- Side Navigation -->
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark"
				id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<div class="sb-sidenav-menu-heading">Core</div>
						<a class="nav-link"
							href="<%=request.getContextPath()%>/consumer_dashboard.jsp"><i
							class="fas fa-home"></i> Dashboard</a>
						<div class="sb-sidenav-menu-heading">Products</div>
						<a class="nav-link"
							href="<%=request.getContextPath()%>/ProductsServlet?action=viewProducts&role=Consumer">
							<i class="fa-brands fa-product-hunt"></i> View Products
						</a>
						<div class="sb-sidenav-menu-heading">Orders</div>
						<a class="nav-link"
							href="<%=request.getContextPath()%>/OrdersServlet?action=viewOrders&role=Consumer">
							<i class="fa-solid fa-cart-shopping"></i> View Orders
						</a>
						<div class="sb-sidenav-menu-heading">Issues</div>
						<a class="nav-link" href="reportIssue.jsp"><i
							class="fa-solid fa-flag"></i> Report Issue</a>
						<div class="sb-sidenav-menu-heading">Track Order</div>
						<a class="nav-link" href="trackOrder.jsp"><i
							class="fa-solid fa-truck-front"></i> Track Order</a>
						<div class="sb-sidenav-menu-heading">Settings</div>
						<a class="nav-link active" href="ConsumerProfileSettings.jsp"><i
							class="fa-solid fa-user"></i> Profile Settings</a>
					</div>
				</div>
			</nav>
		</div>

		<!-- Main Content -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">Update Profile</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="consumer_dashboard.jsp">Dashboard</a></li>
						<li class="breadcrumb-item active">Update Profile</li>
					</ol>

					<!-- Error Message Display -->
					<%
					String errorMessage = (String) request.getAttribute("errorMessage");
					%>
					<%
					if (errorMessage != null) {
					%>
					<div class="alert alert-danger" role="alert">
						<%=errorMessage%>
					</div>
					<%
					}
					%>

					<!-- Profile Update Form -->
					<div class="container">
						<form action="ConsumerServlet" method="post">
							<input type="hidden" name="port_id" value="<%=userId%>" />
							<div class="mb-3">
								<label for="location" class="form-label">Location</label> <input
									type="text" class="form-control" id="location" name="location" >
							</div>
							<div class="mb-3">
								<label for="password" class="form-label">Current
									Password</label> <input type="password" class="form-control"
									id="password" name="password" required>
							</div>
							<div class="mb-3">
								<label for="newpassword" class="form-label">New Password</label>
								<input type="password" class="form-control" id="newpassword"
									name="newpassword" required>
							</div>
							<div class="mb-3">
								<label for="confirmPassword" class="form-label">Re-enter
									New Password</label> <input type="password" class="form-control"
									id="confirmPassword" name="confirmPassword" required>
								<div id="passwordError" class="error-message"
									style="display: none; color: red;">Passwords do not match</div>
							</div>
							<button type="submit" class="btn btn-primary">Update
								Profile</button>
						</form>
					</div>
				</div>
			</main>

			<!-- Footer Section -->
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">&copy; PortERP 2024</div>
					</div>
				</div>
			</footer>
		</div>
	</div>

	<!-- Scripts -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
</body>
</html>