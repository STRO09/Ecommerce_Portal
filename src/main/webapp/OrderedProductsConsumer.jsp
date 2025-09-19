<%@page import="implementors.OrdersImplementor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %>
<%@ page import="models.ProductsPojo, models.OrdersPojo" %>
     
<% 
    session = request.getSession(false);
    if (session == null || session.getAttribute("userId") == null || !session.getAttribute("role").equals("Consumer")) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (int) session.getAttribute("userId");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Consumer Dashboard | PortERP</title>
    <link href="<%= request.getContextPath() %>/css/styles.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .card-header {
            background-color: #343a40;
            color: #fff;
            font-weight: bold;
            padding: 10px;
            text-align: center;
        }
        h2 {
            color: #333;
            padding-top: 20px;
            text-align: center;
        }
        .table-responsive {
            overflow-x: auto;
        }
        .table {
            margin-top: 20px;
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .table thead {
            background-color: #f2f2f2;
            color: #333;
        }
        .table tbody tr:hover {
            background-color: #f5f5f5;
        }
        .footer {
            background-color: #f8f9fa;
            padding: 20px 0;
            text-align: center;
            font-size: 0.9rem;
        }
    </style>
</head>

<body class="sb-nav-fixed">
    <!-- Top Navbar -->
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
    <div id="layoutSidenav">
      <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
          <div class="sb-sidenav-menu">
            <div class="nav">
              <div class="sb-sidenav-menu-heading">Core</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/consumer_dashboard.jsp">
                <i class="fas fa-home"></i>
                Dashboard
              </a>
              
              <div class="sb-sidenav-menu-heading">Products</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/ProductsServlet?action=viewProducts&role=Consumer">
                <i class="fa-brands fa-product-hunt"></i>
                View Products
              </a>

              <div class="sb-sidenav-menu-heading">Orders</div>
              <a class="nav-link active" href="<%= request.getContextPath() %>/OrdersServlet?action=viewOrders&role=Consumer">
                <i class="fa-solid fa-cart-shopping"></i>
                View Orders
              </a>

              <div class="sb-sidenav-menu-heading">Issues</div>
              <a class="nav-link" href="reportIssue.jsp">
                <i class="fas fa-exclamation-triangle"></i>
                Report Issues
              </a>
            
            <div class="sb-sidenav-menu-heading">Track Order</div>
              <a class="nav-link" href="trackOrder.jsp">
                <i class="fa-solid fa-truck-front"></i>
                Track Order
              </a>

            
            <div class="sb-sidenav-menu-heading">Settings</div>
              <a class="nav-link" href="ConsumerProfileSettings.jsp">
                <i class="fa-solid fa-user"></i>
                Update Profile
              </a>
            </div>
          </div>
        </nav>
              </div>

        <!-- Main Content -->
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    
                    <!-- Orders Table -->
                    <section>
                        <div class="container-fluid px-4">
                <h1 class="mt-4">View Orders</h1>
                <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="consumer_dashboard.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item active">Orders List</li>
                    </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-shopping-cart me-1"></i> Order History
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Product ID</th>
                                            <th>Consumer Port ID</th>
                                            <th>Quantity</th>
                                            <th>Order Date</th>
                                            <th>Order Placed</th>
                                            <th>Order Shipped</th>
                                            <th>Out for Delivery</th>
                                            <th>Delivered</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <% 
                                    OrdersImplementor implementor=new OrdersImplementor();
                                        List<OrdersPojo> ordersList = implementor.viewOrdersConsumer(userId);
                                        if (ordersList != null && !ordersList.isEmpty()) {
                                            for (OrdersPojo order : ordersList) {
                                    %>
                                        <tr>
                                            <td><%= order.getOrder_id() %></td>
                                            <td><%= order.getProduct_id() %></td>
                                            <td><%= order.getConsumer_port_id() %></td>
                                            <td><%= order.getQuantity() %></td>
                                            <td><%= order.getOrder_date() %></td>
                                            <td><%= order.isOrder_placed() ? "Yes" : "No" %></td>
                                            <td><%= order.isShipped() ? "Yes" : "No" %></td>
                                            <td><%= order.isOut_for_delivery() ? "Yes" : "No" %></td>
                                            <td><%= order.isDelivered() ? "Yes" : "No" %></td>
                                        </tr>
                                    <% } } else { %>
                                        <tr><td colspan="9">No Orders Found</td></tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>
                </div>
            </main>

            <!-- Footer -->
            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid px-4 text-center">
                    <small class="text-muted">&copy; PortERP 2024</small>
                </div>
            </footer>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
</body>
</html>