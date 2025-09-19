<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="models.ProductsPojo"%>
<%@ page import="java.util.List"%>
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


<script>
    // Auto-dismiss alert after 3 seconds
    setTimeout(() => {
        const alert = document.getElementById('alert-danger');
        if (alert) {
            alert.classList.remove('show');  // Remove 'show' class to start fading
            alert.classList.add('fade');     // Add 'fade' class to fade it out

            // Remove from DOM after fade transition (waits 500ms to complete the fade)
            setTimeout(() => alert.remove(), 500); 
        }
    }, 3000); // 3-second delay before starting to fade out
</script>
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
						href="<%=request.getContextPath()%>/LogoutServlet">Logout</a></li>
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
							href="<%=request.getContextPath()%>/consumer_dashboard.jsp">
							<i class="fas fa-home"></i> Dashboard
						</a>

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
						<a class="nav-link" href="reportIssue.jsp"> <i
							class="fas fa-exclamation-triangle"></i> Report Issues
						</a>

						<div class="sb-sidenav-menu-heading">Track Order</div>
						<a class="nav-link" href="trackOrder.jsp"> <i
							class="fa-solid fa-truck-front"></i> Track Order
						</a>


						<div class="sb-sidenav-menu-heading">Settings</div>
						<a class="nav-link" href="ConsumerProfileSettings.jsp"> <i
							class="fa-solid fa-user"></i> Update Profile
						</a>
					</div>
				</div>
			</nav>
		</div>
		<!-- Main Content -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">Place Order</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="consumer_dashboard.jsp">Dashboard</a></li>
						<li class="breadcrumb-item active"><a
							href="<%=request.getContextPath()%>/ProductsServlet?action=viewProducts&role=Consumer">Products List</a></li>
						<li class="breadcrumb-item active">Place Order</li>
					</ol>

					<!-- Product Order Form -->
					<!-- Product Order Form -->
					<section class="form-container">
						<div class="card fat">
							<div class="card-body">
								<%
								// Retrieve product_id from request and consumer port ID from session
								int productId = Integer.parseInt(request.getParameter("product_id"));
								String productName = request.getParameter("product_name");
								String productPrice = request.getParameter("product_price");
								int available_quantity = Integer.parseInt(request.getParameter("available_quantity"));
								int consumerPortId = (int) session.getAttribute("userId");

								ProductsPojo product = new ProductsPojo();
								product.setProduct_id(productId);
								ProductsPojo selectedProduct = product.viewProductDetails(productId);

								// Error message initialization
								 String errorMessage = request.getParameter("error");

								int orderQuantity = 0;
								if (request.getParameter("quantity") != null) {
									orderQuantity = Integer.parseInt(request.getParameter("quantity"));

									if (orderQuantity > selectedProduct.getQuantity()) {
										errorMessage = "Ordered quantity exceeds available stock.";
									}
								}
								%>

								<%
								if (errorMessage != null) {
								%>
								<div class="alert alert-danger alert-dismissible fade show"
									role="alert">
									<%=errorMessage%>
									<button type="button" class="btn-close" data-bs-dismiss="alert"
									aria-label="Close"></button>
								</div>
								
								<%
								}
								%>
								<form action="OrdersServlet" method="POST" class="form-table">
									<!-- Read-only field for product_id -->
									<div class="form-group mb-3">
										<label for="product_id" class="form-label">Product ID:</label>
										<input type="text" name="product_id"
											class="form-control locked-input "
											value="<%=selectedProduct.getProduct_id()%>" readonly />
									</div>

									<div class="form-group mb-3">
										<label for="product_name" class="form-label">Product
											Name:</label> <input type="text" name="product_name"
											class="form-control locked-input"
											value="<%=selectedProduct.getProduct_name()%>" readonly />
									</div>

									<div class="form-group mb-3">
										<label for="product_price" class="form-label">Price:</label> <input
											type="text" name="product_price"
											class="form-control locked-input"
											value="<%=selectedProduct.getPrice()%>" readonly />
									</div>

									<!-- Read-only field for consumer port ID -->

									<input type="hidden" name="con_port_id" id="con_port_id"
										class="form-control" value="<%=consumerPortId%>" readonly />


									<input type="hidden" name="available_quantity"
										value="<%=available_quantity%>">

									<!-- Input for quantity -->
									<div class="form-group mb-3">
										<label for="quantity" class="form-label">Quantity:</label> <input
											type="number" name="quantity" id="quantity"
											class="form-control" placeholder="Enter Quantity" required
											min=1 />
									</div>

									<!-- Place Order Button -->
									<div class="d-grid">
										<button type="submit" name="action" value="placeOrder"
											class="btn btn-primary btn-block">Place Order</button>
									</div>
								</form>
							</div>
						</div>
					</section>


				</div>
			</main>

			<!-- Footer -->
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

	<!-- Bootstrap and necessary scripts -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
	 
</body>
</html>