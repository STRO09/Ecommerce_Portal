<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List"%>
<%@ page import="models.ReportedProductsPojo"%>
<% 
    session = request.getSession(false);  // Get the existing session, do not create a new one
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");  // Redirect if no session exists
        return;
    }
    int userId = (int) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Issues | PortERP</title>

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" />

<!-- Custom CSS -->
<link rel="stylesheet" href="css/styles.css" />


<!-- Simple DataTables CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<style type="text/css">
table {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #dee2e6; /* Adding a solid border */
}

table th, table td {
	border: 1px solid #dee2e6; /* Add borders between cells */
	padding: 10px;
	text-align: left;
}

.datatable-select select {
  appearance: none; /* Hide the default select box appearance */
  -webkit-appearance: none;
  -moz-appearance: none;
  background: transparent;
  border: none;
  outline: none;
  padding-right: 30px;
  font-size: 0; /* Hide the text inside the dropdown */
  cursor: pointer;
  position: relative;
}

.datatable-select::after {
  content: "\f078"; /* Unicode for down arrow in Font Awesome */
  font-family: "FontAwesome";
  font-size: 16px;
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  pointer-events: none; /* Prevent interaction with the arrow */
}
</style>
</head>

<body class="sb-nav-fixed">
	<!-- Top Navbar -->
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<a class="navbar-brand ps-3" href="seller-dashboard.jsp"><center>PortERP</center></a>
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
			id="sidebarToggle" href="#!">
			<i class="fas fa-bars"></i>
		</button>
		<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
				role="button" data-bs-toggle="dropdown" aria-expanded="false"> <i
					class="fas fa-user fa-fw"></i>
			</a>
				<ul class="dropdown-menu dropdown-menu-end"
					aria-labelledby="navbarDropdown">
					<li><a class="dropdown-item" href="<%= request.getContextPath() %>/LogoutServlet">Logout</a></li>
				</ul></li>
		</ul>
	</nav>

	<!-- Side Navigation -->
	<div id="layoutSidenav">
      <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
          <div class="sb-sidenav-menu">
            <div class="nav">
              <div class="sb-sidenav-menu-heading">Core</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/seller-dashboard.jsp">
                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                Dashboard
              </a>
              
              <div class="sb-sidenav-menu-heading">Products</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/ProductsServlet?action=viewProducts&role=Seller">
                <div class="sb-nav-link-icon"><i class="fas fa-cogs"></i></div>
                Manage Products
              </a>

              <div class="sb-sidenav-menu-heading">Orders</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/OrdersServlet?action=viewOrders">
                <div class="sb-nav-link-icon"><i class="fas fa-list"></i></div>
                Manage Orders
              </a>

              <div class="sb-sidenav-menu-heading">Issues</div>
              <a class="nav-link active" href="<%= request.getContextPath() %>/IssuesServlet?action=viewIssues">
                <div class="sb-nav-link-icon"><i class="fas fa-exclamation-triangle"></i></div>
                View Issues
              </a>
            </div>
          </div>
        </nav>
      </div>

		<!-- Main Content -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">Issues</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="seller-dashboard.jsp">Dashboard</a>
						</li>
						<li class="breadcrumb-item active">Issues</li>
					</ol>

					<!-- Issues Table -->
					<div class="card mb-4">
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>Report ID</th>
										<th>Consumer Port ID</th>
										<th>Product ID</th>
										<th>Issue Type</th>
										<th>Solution</th>
										<th>Report Date</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
									<%
									List<ReportedProductsPojo> reportList = (List<ReportedProductsPojo>) request.getAttribute("reportList");
									if (reportList != null && !reportList.isEmpty()) {
										for (ReportedProductsPojo reports : reportList) {
									%>
									<tr>
										<td><%=reports.getReport_id()%></td>
										<td><%=reports.getConsumer_port_id()%></td>
										<td><%=reports.getProduct_id()%></td>
										<td><%=reports.getIssue_type()%></td>
										<td><%=reports.getSolution()%></td>
										<td><%=reports.getReport_date()%></td>
										<td><%=(reports.getSolution() != null && !reports.getSolution().equals("Pending")) ? "Solved" : "Pending"%></td>
									</tr>
									<%
									}
									} else {
									%>
									<tr>
										<td colspan="7" class="text-center">No Issues Found</td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>
					</div>
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

	<!-- Scripts -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script>
		// Initialize DataTables with dropdown for number of entries
		const dataTable = new simpleDatatables.DataTable("#datatablesSimple", {
			searchable : true,
			fixedHeight : true,
			perPageSelect : [ 5, 10, 15, 20 ], // Options for number of entries
			labels : {
				placeholder : "Search...",
				perPage : "Select entries per page",
				noRows : "No issues found",
				info : "Showing {start} to {end} of {rows} entries",
			},
		});
	</script>

</body>
</html>