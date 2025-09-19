<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import = "models.*" %>
<%@ page import = "implementors.*" %>
<% 
    session = request.getSession(false);  // Get the existing session, do not create a new one
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");  // Redirect if no session exists
        return;
    }
    int userId = (int) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consumer Profile | PortERP</title>

    <!-- Bootstrap, Font Awesome, and Custom CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="css/styles.css" rel="stylesheet" />

    <style>
        /* Additional Styles */
        body {
            background-color: #f0f2f5; /* Light background for better contrast */
        }
        .container {
            margin-bottom: 20px;
            padding: 25px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #4CAF50; /* Theme color for headings */
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            color: #333;
        }
        input[type="text"] {
            border: 1px solid #ced4da;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus {
            border-color: #4CAF50; /* Highlight on focus */
            outline: none;
        }
        .btn-track {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-track:hover {
            background-color: #45a049;
        }
        .alert {
            margin-top: 15px; /* Add space above the alert */
        }
    </style>
</head>

<body class="sb-nav-fixed">
    <!-- Navigation Bar -->
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand ps-3" href="<%= request.getContextPath() %>/consumer_dashboard.jsp"><center>PortERP</center></a>
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>

        <!-- Navbar User Options -->
        <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-user fa-fw"></i>
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item" href="<%= request.getContextPath() %>/LogoutServlet">Logout</a></li>
                </ul>
            </li>
        </ul>
    </nav>

    <!-- Side Navigation -->
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading">Core</div>
                        <a class="nav-link" href="<%= request.getContextPath() %>/consumer_dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
                        <div class="sb-sidenav-menu-heading">Products</div>
                        <a class="nav-link" href="<%= request.getContextPath() %>/ProductsServlet?action=viewProducts&role=Consumer">
                            <i class="fa-brands fa-product-hunt"></i> View Products
                        </a>
                        <div class="sb-sidenav-menu-heading">Orders</div>
                        <a class="nav-link" href="<%= request.getContextPath() %>/OrdersServlet?action=viewOrders&role=Consumer">
                            <i class="fa-solid fa-cart-shopping"></i> View Orders
                        </a>
                        <div class="sb-sidenav-menu-heading">Issues</div>
                        <a class="nav-link" href="reportIssue.jsp"><i class="fa-solid fa-flag"></i> Report Issue</a>
                        <div class="sb-sidenav-menu-heading">Track Order</div>
                        <a class="nav-link active" href="trackOrder.jsp"><i class="fa-solid fa-truck-front"></i> Track Order</a>
                        <div class="sb-sidenav-menu-heading">Settings</div>
                        <a class="nav-link" href="ConsumerProfileSettings.jsp"><i class="fa-solid fa-user"></i> Profile Settings</a>
                    </div>
                </div>
            </nav>
        </div>

        <!-- Main Content -->
        <div id="layoutSidenav_content">
            <main>
                <div class="container track-order-container">
                    <h1 class="mt-4">Track Order</h1>
                   <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="consumer_dashboard.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item active">Orders</li>
                    </ol>
        
        <%
							OrdersImplementor ordersImplementor = new OrdersImplementor();
							ProductsImplementor productsImplementor = new ProductsImplementor();
							List<OrdersPojo> ordersList = ordersImplementor.viewOrdersConsumer(userId);

							// Initialize a raw map to store productId and productName
							Map productMap = new HashMap();

							for (OrdersPojo order : ordersList) {
								int productId = order.getProduct_id();
								int orderId = order.getOrder_id();
								ProductsPojo product = productsImplementor.viewProductDetails(productId);

								if (product != null) {
									productMap.put(orderId, product.getProduct_name());
								}
							}
							%>
                    <!-- Order ID Input Form -->
                    <form action="OrdersServlet" method="POST">
                        <input type="hidden" name="action" value="trackOrder">
                        <div class="mb-3">
                            <label for="order_id" class="form-label">Track your Order: </label>
                          <select id="order_id" name="order_id" class="form-select" required>
										<option value="">Select an Ordered Product</option>
										<%
										for (Object obj : productMap.entrySet()) {
											Map.Entry entry = (Map.Entry) obj;
											int orderId = (Integer) entry.getKey();
											String productName = (String) entry.getValue();
										%>
										<option value="<%=orderId%>"><%=productName%></option>
										<%
										}
										%>
									</select>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-track">Track Order</button>
                        </div>
                    </form>

                    <% 
                        // Show error message if provided by OrdersServlet
                        String errorMessage = (String) request.getAttribute("error");
                        if (errorMessage != null) { 
                    %>
                        <div class="alert alert-danger text-center"><%= errorMessage %></div>
                    <% } %>
                </div>
            </main>

            <!-- Footer Section -->
            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid px-4">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted">&copy; PortERP 2024</div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>