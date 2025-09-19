<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="models.ProductsPojo" %>
<%@ page import="java.util.List" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Dashboard | Update Product</title>

    <!-- Include Bootstrap and custom styles -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
  </head>

  <body class="sb-nav-fixed">
    <!-- Navigation Bar -->
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
      <a class="navbar-brand ps-3" href="consumer-dashboard.jsp">PortERP</a>
      <button class="btn btn-link btn-sm order-1 order-lg-0 me-4" id="sidebarToggle" href="#!">
        <i class="fas fa-bars"></i>
      </button>
      <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown">
            <i class="fas fa-user fa-fw"></i>
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
          </ul>
        </li>
      </ul>
    </nav>

    <!-- Sidebar Navigation -->
    <div id="layoutSidenav">
      <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
          <div class="sb-sidenav-menu">
            <div class="nav">
              <div class="sb-sidenav-menu-heading">Core</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/consumer-dashboard.jsp">
                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                Dashboard
              </a>
              <div class="sb-sidenav-menu-heading">Products</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/ProductsServlet?action=viewProducts&role=Seller">
                <div class="sb-nav-link-icon"><i class="fas fa-box"></i></div>
                Manage Products
              </a>
              <div class="sb-sidenav-menu-heading">Orders</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/OrdersServlet?action=viewOrders">
                <div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>
                Manage Orders
              </a>
              <div class="sb-sidenav-menu-heading">Issues</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/IssuesServlet?action=viewIssues">
                <div class="sb-nav-link-icon"><i class="fas fa-exclamation-circle"></i></div>
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
            <h1 class="mt-4">Update Product</h1>
            <ol class="breadcrumb mb-4">
					<li class="breadcrumb-item"><a href="seller-dashboard.jsp">Dashboard</a>
						<li class="breadcrumb-item"><a href="ProductsServlet?action=viewProducts&role=Seller">Products</a></li>
						<li class="breadcrumb-item active">Update Product</li>
					</ol>

            <!-- Product Update Form -->
            <section class="form-container">
              <div class="card fat">
                <div class="card-body">
                  <%
                    int productId = Integer.parseInt(request.getParameter("product_id"));
                    ProductsPojo product = new ProductsPojo();
                    product.setProduct_id(productId);
                    ProductsPojo selectedProduct = product.viewProductDetails(productId);
                  %>
                  <form action="ProductsServlet" method="POST" class="form-table">
                    <input type="hidden" name="product_id" value="<%= selectedProduct.getProduct_id() %>" />

                    <div class="form-group mb-3">
                      <label for="product_name" class="form-label">Product Name:</label>
                      <input type="text" name="product_name" id="product_name" class="form-control" value="<%= selectedProduct.getProduct_name() %>" required />
                    </div>

                    <div class="form-group mb-3">
                      <label for="quantity" class="form-label">Quantity:</label>
                      <input type="number" name="quantity" id="quantity" class="form-control" value="<%= selectedProduct.getQuantity() %>" required />
                    </div>

                    <div class="form-group mb-3">
                      <label for="price" class="form-label">Price:</label>
                      <input type="text" name="price" id="price" class="form-control" value="<%= selectedProduct.getPrice() %>" required />
                    </div>

                    <div class="d-grid">
                      <button type="submit" name="action" value="update" class="btn btn-primary btn-block">Update Product</button>
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
            <div class="d-flex align-items-center justify-content-between small">
              <div class="text-muted">Copyright &copy; PortERP 2024</div>
            </div>
          </div>
        </footer>
      </div>
    </div>

    <!-- Bootstrap and necessary scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
  </body>
</html>