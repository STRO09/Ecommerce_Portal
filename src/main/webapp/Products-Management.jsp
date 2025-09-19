<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %>
<%@ page import="models.ProductsPojo" %>
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
<title>Manage Products | PortERP</title>
    
    <!-- Font Awesome and External Stylesheets -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css" />
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />

    <!-- JavaScript for Delete Confirmation -->
    <script>
      function confirmDelete(productId) {
        if (confirm("Are you sure you want to delete this product?")) {
          window.location.href = 'ProductsServlet?action=delete&product_id=' + productId;
        }
      }
    </script>
  </head>

  <body class="sb-nav-fixed">
    <!-- Navigation Bar -->
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
      <a class="navbar-brand ps-3" href="<%= request.getContextPath() %>/seller-dashboard.jsp"><center>PortERP</center></a>
      <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>

      <!-- Navbar User Options -->
      <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-user fa-fw"></i>
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/logout.jsp">Logout</a></li>
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
              <a class="nav-link" href="<%= request.getContextPath() %>/seller-dashboard.jsp">
                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                Dashboard
              </a>
              
              <div class="sb-sidenav-menu-heading">Products</div>
              <a class="nav-link active" href="<%= request.getContextPath() %>/ProductsServlet?action=viewProducts&role=Seller">
                <div class="sb-nav-link-icon"><i class="fas fa-cogs"></i></div>
                Manage Products
              </a>

              <div class="sb-sidenav-menu-heading">Orders</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/OrdersServlet?action=viewOrders">
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

      <!-- Main Content Area -->
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Products Management</h1>
            <ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="seller-dashboard.jsp">Dashboard</a>
						</li>
						<li class="breadcrumb-item active">Products</li>
					</ol>

            <!-- Products Table -->
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th>Product ID</th>
                  <th>Product Name</th>
                  <th>Quantity</th>
                  <th>Price</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <%
                  @SuppressWarnings("unchecked")
                  List<ProductsPojo> productList = (List<ProductsPojo>) request.getAttribute("productList");
                  if (productList != null && !productList.isEmpty()) {
                    for (ProductsPojo product : productList) {
                %>
                <tr>
                  <td><%= product.getProduct_id() %></td>
                  <td><%= product.getProduct_name() %></td>
                  <td><%= product.getQuantity() %></td>
                  <td><%= product.getPrice() %></td>
                  <td>
                    <a href="UpdateProductForm.jsp?product_id=<%= product.getProduct_id() %>" class="btn btn-primary">Update</a>
                    <button class="btn btn-danger" onclick="confirmDelete(<%= product.getProduct_id() %>)">Delete</button>
                  </td>
                </tr>
                <%
                    }
                  } else {
                %>
                <tr>
                  <td colspan="5">No Products Found</td>
                </tr>
                <%
                  }
                %>
              </tbody>
            </table>

            <!-- Add New Product Button -->
            <div class="add-product mb-4">
              <a href="AddProductForm.jsp" class="btn btn-success">Add New Product</a>
            </div>
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

    <!-- JS Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="<%= request.getContextPath() %>/js/scripts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="<%= request.getContextPath() %>/js/datatables-simple-demo.js"></script>
  </body>
</html>