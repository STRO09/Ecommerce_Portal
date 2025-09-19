<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
session = request.getSession(false); // Get the existing session, do not create a new one
if (session == null || session.getAttribute("userId") == null) {
	response.sendRedirect("login.jsp"); // Redirect if no session exists
	return;
}
int userId = (int) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard | Update Product</title>

<!-- Include Bootstrap and custom styles -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>

<style>
/* Custom styles for the form layout */
.form-container {
	max-width: 800px; /* Adjust size for better layout */
	margin: 50px auto; /* Center the form horizontally */
	padding: 30px;
	background-color: #f8f9fa; /* Light background for contrast */
	border-radius: 12px; /* Rounded corners */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Light shadow for depth */
}

.form-table {
	width: 100%;
	padding: 20px;
}

label {
	margin-bottom: 5px; /* Add space between label and input field */
}

.form-control {
	margin-bottom: 20px; /* Add space between input fields */
}

/* Button Styles */
.btn-primary {
	background-color: #007bff; /* Use a vibrant blue for primary action */
	border: none; /* Remove border for a cleaner look */
}

.btn-primary:hover {
	background-color: #0056b3; /* Darker shade on hover */
}

.btn-block {
	width: 100%; /* Ensure the button takes full width */
}
</style>
</head>

<body class="sb-nav-fixed">
	<!-- Navigation Bar -->
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<a class="navbar-brand ps-3"
			href="<%=request.getContextPath()%>/home.jsp"><center>PortERP</center></a>

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
						href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				</ul></li>
		</ul>
	</nav>

	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark"
				id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<div class="sb-sidenav-menu-heading">Core</div>
						<a class="nav-link"
							href="<%=request.getContextPath()%>/seller-dashboard.jsp">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> Dashboard
						</a>
						<div class="sb-sidenav-menu-heading">Products</div>
						<a class="nav-link"
							href="<%=request.getContextPath()%>/ProductsServlet?action=viewProducts&role=Seller">
							<div class="sb-nav-link-icon">
								<i class="fas fa-box"></i>
							</div> Manage Products
						</a>
						<div class="sb-sidenav-menu-heading">Orders</div>
						<a class="nav-link"
							href="<%=request.getContextPath()%>/OrdersServlet?action=viewOrders">
							<div class="sb-nav-link-icon">
								<i class="fas fa-shopping-cart"></i>
							</div> Manage Orders
						</a>
						<div class="sb-sidenav-menu-heading">Issues</div>
						<a class="nav-link"
							href="<%=request.getContextPath()%>/IssuesServlet?action=viewIssues">
							<div class="sb-nav-link-icon">
								<i class="fas fa-exclamation-circle"></i>
							</div> View Issues
						</a>
					</div>
				</div>
			</nav>
		</div>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4 ">
					<h1 class="mt-4">Add Products</h1>
					<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item"><a href="seller-dashboard.jsp">Dashboard</a>
						<li class="breadcrumb-item"><a href="ProductsServlet?action=viewProducts&role=Seller">Products</a></li>
						<li class="breadcrumb-item active">Add a new Product</li>
					</ol>

					<!-- Product Update Form -->
					<section class="form-container">
						<form action="ProductsServlet" method="post" class="form-table">
							<input type="hidden" name="action" value="add" />

							<div class="mb-3">
								<label for="product_id">Product ID:</label> <input type="text"
									id="product_id" name="product_id" class="form-control" required />
							</div>

							<div class="mb-3">
								<label for="product_name">Product Name:</label> <input
									type="text" id="product_name" name="product_name"
									class="form-control" required />
							</div>

							<div class="mb-3">
								<label for="quantity">Quantity:</label> <input type="number"
									id="quantity" name="quantity" class="form-control" required
									min="1" />
							</div>

							<div class="mb-3">
								<label for="price">Price:</label> <input type="number"
									id="price" name="price" class="form-control" required
									step="0.01" />
							</div>

							<div class="d-grid">
								<button type="submit" class="btn btn-primary btn-block">Add
									Product</button>
							</div>
						</form>
					</section>
				</div>
			</main>

			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; PortERP 2024</div>
					</div>
				</div>
			</footer>
		</div>
	</div>

	<!-- Include Bootstrap and necessary JS files -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
</body>
</html>