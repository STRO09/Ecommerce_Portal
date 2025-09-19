<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List"%>
<%@ page import="implementors.*"%>
<%@ page import="models.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>

<%
session = request.getSession(false);
if (session == null || session.getAttribute("userId") == null || !session.getAttribute("role").equals("Consumer")) {
	response.sendRedirect("login.jsp");
	return;
}

int userId = (int) session.getAttribute("userId");
String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report Issue | PortERP</title>

<!-- Font Awesome and Custom CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/styles.css">
</head>

<body class="sb-nav-fixed">
	<!-- Navbar -->
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<a class="navbar-brand ps-3" href="<%=request.getContextPath()%>/consumer_dashboard.jsp"><center>PortERP</center></a>
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle">
			<i class="fas fa-bars"></i>
		</button>
		<ul class="navbar-nav ms-auto me-4">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
				role="button" data-bs-toggle="dropdown"> <i
					class="fas fa-user fa-fw"></i>
			</a>
				<ul class="dropdown-menu dropdown-menu-end">
					<li><a class="dropdown-item"
						href="<%=request.getContextPath()%>/LogoutServlet">Logout</a></li>
				</ul></li>
		</ul>
	</nav>

	<!-- Sidebar -->
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
							href="<%=request.getContextPath()%>/ProductsServlet?action=viewProducts&role=Consumer"><i
							class="fa-brands fa-product-hunt"></i> View Products</a>

						<div class="sb-sidenav-menu-heading">Orders</div>
						<a class="nav-link"
							href="<%=request.getContextPath()%>/OrdersServlet?action=viewOrders&role=Consumer"><i
							class="fa-solid fa-cart-shopping"></i> View Orders</a>

						<div class="sb-sidenav-menu-heading">Issues</div>
						<a class="nav-link active" href="reportIssue.jsp"><i
							class="fas fa-flag"></i> Report Issue</a>

						<div class="sb-sidenav-menu-heading">Track Order</div>
						<a class="nav-link" href="trackOrder.jsp"><i
							class="fa-solid fa-truck-front"></i> Track Order</a>

						<div class="sb-sidenav-menu-heading">Settings</div>
						<a class="nav-link" href="ConsumerProfileSettings.jsp"><i
							class="fa-solid fa-user"></i> Update Profile</a>
					</div>
				</div>
			</nav>
		</div>

		<!-- Main Content -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">Report an Issue</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="consumer_dashboard.jsp">Dashboard</a></li>
						<li class="breadcrumb-item active">Report Issue</li>
					</ol>

					<!-- Report Issue Form -->
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-exclamation-circle"></i> Issue Details
						</div>
						<div class="card-body">

							<%
							OrdersImplementor ordersImplementor = new OrdersImplementor();
							ProductsImplementor productsImplementor = new ProductsImplementor();
							List<OrdersPojo> ordersList = ordersImplementor.viewOrdersConsumer(userId);

							// Initialize a raw map to store productId and productName
							Map productMap = new HashMap();

							for (OrdersPojo order : ordersList) {
								int productId = order.getProduct_id();
								ProductsPojo product = productsImplementor.viewProductDetails(productId);

								if (product != null) {
									productMap.put(productId, product.getProduct_name());
								}
							}
							%>

							<form method="POST" action="IssuesServlet">
								<input type="hidden" name="action" value="reportIssue">
								<div class="mb-3">
									<label for="conportid" class="form-label">Consumer Port ID</label>
									<input type="text" id="conportid" name="con_port_id"
										class="form-control locked-input" value="<%=userId%>" readonly>
								</div>

								<div class="mb-3">
									<label for="product_name" class="form-label">Product</label>
									<select id="product_name" name="product_id" class="form-select" required>
										<option value="">Select a Product</option>
										<%
										for (Object obj : productMap.entrySet()) {
											Map.Entry entry = (Map.Entry) obj;
											int productId = (Integer) entry.getKey();
											String productName = (String) entry.getValue();
										%>
										<option value="<%=productId%>"><%=productName%></option>
										<%
										}
										%>
									</select>
								</div>

								<div class="mb-3">
									<label for="issue_type" class="form-label">Issue Type</label>
									<select id="issue_type" name="issue_type" class="form-select" required>
										<option value="Damage">Damage</option>
										<option value="Wrong Product">Wrong Product</option>
										<option value="Delayed">Delayed</option>
										<option value="Still Not Received">Still Not Received</option>
										<option value="Missing">Missing</option>
									</select>
								</div>

								<button type="submit" class="btn btn-primary report-btn">Report Issue</button>
							</form>

							<%
							String resultMessage = request.getParameter("message");
							if (resultMessage != null) {
							%>
							<div class="alert alert-danger mt-3"><%=resultMessage%></div>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</main>

			<!-- Footer -->
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">&copy; PortERP 2024</div>
					</div>
				</div>
			</footer>
		</div>
	</div>

	<!-- JS Scripts -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/scripts.js"></script>
</body>
</html>