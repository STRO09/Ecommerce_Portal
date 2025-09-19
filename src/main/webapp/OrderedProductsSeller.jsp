<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List"%>
<%@ page import="models.OrdersPojo"%>
<%@ page import="implementors.SellerImplementor"%>
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
<title>Dashboard | PortERP</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/css/styles.css"
	rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
	
<script>
        function openModal(orderId) {
            document.getElementById("orderId").value = orderId;
            document.getElementById("statusModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("statusModal").style.display = "none";
        }

        function updateOrderStatus(form) {
            // Submit the form when the update button is clicked
            form.submit();
        }
    </script>
    
    <style>
    /* Style for modal overlay background */
    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        background-color: rgba(0, 0, 0, 0.5); /* Black background with transparency */
    }

    /* Modal content box */
    .modal-content {
        background-color: #fefefe;
        margin: auto;
        padding: 20px;
        border: 1px solid #888;
        width: 30%; /* Adjust the width as per your design */
        position: fixed;
        top: 50%; /* Center vertically */
        left: 50%; /* Center horizontally */
        transform: translate(-50%, -50%); /* Shift to make center exact */
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* Optional shadow */
        border-radius: 8px; /* Optional rounded corners */
    }

    /* Close button style */
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
</style>
    
</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<!-- Navbar Brand-->
		<a class="navbar-brand ps-3" href="seller-dashboard.jsp"><center>PortERP</center></a>
		<!-- Sidebar Toggle-->
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
			id="sidebarToggle" href="#!">
			<i class="fas fa-bars"></i>
		</button>
		<!-- Navbar-->
		<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
				role="button" data-bs-toggle="dropdown" aria-expanded="false"><i
					class="fas fa-user fa-fw"></i></a>
				<ul class="dropdown-menu dropdown-menu-end"
					aria-labelledby="navbarDropdown">

					<li><a class="dropdown-item" href="<%= request.getContextPath() %>/LogoutServlet">Logout</a></li>
				</ul></li>
		</ul>
	</nav>
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
              <a class="nav-link active" href="<%= request.getContextPath() %>/OrdersServlet?action=viewOrders">
                <div class="sb-nav-link-icon"><i class="fas fa-list"></i></div>
                Manage Orders
              </a>

              <div class="sb-sidenav-menu-heading">Issues</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/IssuesServlet?action=viewIssues">
                <div class="sb-nav-link-icon"><i class="fas fa-exclamation-triangle"></i></div>
                View Issues
              </a>
            </div>
          </div>
        </nav>
      </div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">Orders Management</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="seller-dashboard.jsp">Dashboard</a>
						</li>
						<li class="breadcrumb-item active">Orders</li>
					</ol>

					<!-- Order Status Table -->
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> Order Status
						</div>
						<div class="card-body">
							<table id="ordersTable" class="table table-bordered">
								<thead>
									<tr>
										<th>Order ID</th>
						                <th>Product ID</th>
						                <th>Consumer Port ID</th>
						                <th>Quantity</th>
						                <th>Order Date</th>
						                <th>Order Placed</th>
						                <th>Order Shipped</th>
						                <th>Order Out for Delivery</th>
						                <th>Order Delivered</th>
						                <th>Actions</th>

									</tr>
								</thead>
								<tbody>
									<%
									@SuppressWarnings("unchecked")
									List<OrdersPojo> ordersList = (List<OrdersPojo>) request.getAttribute("ordersList");
									if (ordersList != null && !ordersList.isEmpty()) {
										for (OrdersPojo order : ordersList) {
									%>
									<tr>
										<td><%=order.getOrder_id()%></td>
										<td><%=order.getProduct_id()%></td>
										<td><%=order.getConsumer_port_id() %></td>
										<td><%=order.getQuantity()%></td>
										<td><%=order.getOrder_date()%></td>
										<td><%= order.isOrder_placed() ? "Yes" : "No" %></td>
						                <td><%= order.isShipped() ? "Yes" : "No"%></td>
						                <td><%= order.isOut_for_delivery() ? "Yes" : "No"%></td>
						                <td><%= order.isDelivered() ? "Yes" : "No"%></td>
						                <td>
						                    <button onclick="openModal('<%= order.getOrder_id() %>')" class="btn btn-primary">Update</button>
						                </td>

									</tr>
									<%
									}
									} else {
									%>
									<tr>
										<td colspan="8">No Orders Found</td>
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

			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; PortERP 2024</div>
					</div>
				</div>
			</footer>
		</div>
		<!-- Modal for updating order status -->
<div id="statusModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Update Order Status</h2>
        <form method="post" action="<%= request.getContextPath() %>/OrdersServlet" onsubmit="return updateOrderStatus(this);">
            <input type="hidden" name="action" value="UpdateOrderStatus" />
            <input type="hidden" name="orderId" id="orderId" />
            <label for="newStatus">New Status:</label>
            <select name="newStatus" id="newStatus" required>
            	<option value="Order Placed">Order Placed</option>
                <option value="Shipped">Shipped</option>
                <option value="Out for Delivery">Out for Delivery</option>
                <option value="Delivered">Delivered</option>
            </select>
            <br><br>
            <button type="submit">Update Status</button>
        </form>
    </div>
</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath()%>/js/scripts.js"></script>
</body>
</html>