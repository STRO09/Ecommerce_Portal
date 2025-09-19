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
 <title>Dashboard | PortERP</title>
    <link
      href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
      rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"></script>
  </head>
  <body class="sb-nav-fixed">
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
              <a class="nav-link active" href="<%= request.getContextPath() %>/ProductsServlet?action=viewProducts&role=Consumer">
                <i class="fa-brands fa-product-hunt"></i>
                View Products
              </a>

              <div class="sb-sidenav-menu-heading">Orders</div>
              <a class="nav-link" href="<%= request.getContextPath() %>/OrdersServlet?action=viewOrders&role=Consumer">
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
      <div id="layoutSidenav_content">
            <main>
              <div class="container-fluid px-4">
                <h1 class="mt-4">View Products</h1>
                <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="consumer_dashboard.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item active">Products List</li>
                    </ol>
    
                <!-- Products Table -->
                <div class="card mb-4">
                  <div class="card-header">
                    <i class="fas fa-cart-arrow-down me-1"></i>
                    Available Products
                  </div>
                  <div class="card-body">
                    <table class="table table-bordered table-striped" id="productsTable">
                      <thead>
                        <tr>
                          <th>Product ID</th>
                          <th>Product Name</th>
                          <th>Price</th>
                          <th>Available Quantity</th>
                          <th>Action</th>
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
            			   <td><%= product.getPrice() %></td>
            			   <td><%= product.getQuantity() %></td>
            			   
                          <td>
                          <a href="PlaceOrderForm.jsp?product_id=<%= product.getProduct_id() %>&product_name=<%=product.getProduct_name() %>&product_price=<%=product.getPrice() %>&available_quantity=<%=product.getQuantity()%>">
                          <button class="btn btn-primary place-order-btn">Place Order</button></a>
                            
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
                  </div>
                </div>
              </div>
            </main>
            <footer class="py-4 bg-light mt-auto">
              <div class="container-fluid px-4">
                <div class="d-flex align-items-center justify-content-between small">
                  <div class="text-muted">Copyright &copy; PortERP 2024</div>
                </div>
              </div>
            </footer>
          </div>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
      crossorigin="anonymous"></script>
    <script src="assets/demo/chart-area-demo.js"></script>
    <script src="assets/demo/chart-bar-demo.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
      crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script>
  </body>
</html>