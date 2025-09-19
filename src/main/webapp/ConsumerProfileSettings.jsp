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
String role = (String) session.getAttribute("role");
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
					<h1 class="mt-4">Consumer Profile</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="consumer_dashboard.jsp">Dashboard</a></li>
						<li class="breadcrumb-item active">Consumer Profile</li>
					</ol>

					<!-- Profile Update Form -->
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-user"></i> User Details
						</div>
						<div class="card-body">
							<p>
								<strong>Port ID: </strong><%=userId%></p>
							<p>
								<strong>Role: </strong><%=role%></p>
							<p>
								<strong>Location: </strong><%=location%></p>

							<!-- Profile Action Buttons -->
							<div class="d-flex gap-3 mt-3">
								<a href="updateProfile.jsp" class="btn btn-primary"> <i
									class="fas fa-edit"></i> Update Profile
								</a><a
									href="<%=request.getContextPath()%>/LogoutServlet?deleteProfile=true"
									class="btn btn-danger"
									onclick="return confirm('Are you sure you want to delete your account?');">
									<i class="fas fa-trash-alt"></i> Delete Profile
								</a>
							</div>
						</div>
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