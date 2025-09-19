<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
<%@ page import="models.OrdersPojo" %>


<% 
    // Ensure session and user authentication
    session = request.getSession(false);
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (int) session.getAttribute("userId");
    OrdersPojo currentOrder = null;
    

    // Example data (replace with actual order details retrieved from the database)
    List<OrdersPojo> ordersList = (List<OrdersPojo>) request.getAttribute("ordersList");
    
    int orderIdToTrack = Integer.parseInt(request.getParameter("order_id")); // Get this parameter from the request
    for (OrdersPojo order : ordersList) {
        if (order.getOrder_id() == orderIdToTrack) {
            currentOrder = order;
            break;
        }
    }
    
    if (currentOrder == null) {
        out.println("Order not found.");
        return;
    }

    // Calculate progress percentage
    int progress = 0;
    if (currentOrder.isOrder_placed()) progress += 25;
    if (currentOrder.isShipped()) progress += 25;
    if (currentOrder.isOut_for_delivery()) progress += 25;
    if (currentOrder.isDelivered()) progress += 25;

    String progressStyle = "width: " + progress + "%;";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Track Orders | PortERP</title>

    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="<%= request.getContextPath() %>/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

    <style>
        /* Add CSS for progress bar and hover cards */
        .progress-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            margin-top: 30px;
            margin-bottom: 30px;
        }
        .progress-bar {
            width: 100%;
            height: 8px;
            background: linear-gradient(to right, #e0e0e0, #cfcfcf);
            position: relative;
            border-radius: 8px;
            z-index: 1;
        }
        .progress-bar-fill {
            background: linear-gradient(to right, #4caf50, #66bb6a);
            height: 100%;
            border-radius: 8px;
            width: 75%;
            transition: width 0.4s ease, background 0.6s ease;
            z-index: 2;
        }
        .progress-checkpoints {
            display: flex;
            justify-content: space-between;
            width: 100%;
            z-index: 3;
            position: absolute;
            top: -30px;
        }
        .checkpoint {
            text-align: center;
            position: relative;
            cursor: pointer;
            z-index: 5;
        }
        .checkpoint .circle {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 5px;
            font-size: 18px;
            transition: background-color 0.3s ease, transform 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .checkpoint.completed .circle {
            background: linear-gradient(135deg, #4caf50, #81c784);
            color: white;
        }
        .checkpoint.incomplete .circle {
            background: linear-gradient(135deg, #bdbdbd, #d7d7d7);
            color: #888;
        }
        .checkpoint span {
            display: block;
            font-size: 12px;
            color: #666;
        }
        .checkpoint .hover-card {
            display: none;
            position: absolute;
            top: 60px;
            left: 50%;
            transform: translateX(-50%);
            background-color: white;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            z-index: 10;
            width: 250px;
        }
        .checkpoint:hover .hover-card {
            display: block;
        }
        .checkpoint:hover .circle {
            transform: scale(1.2);
        }
    </style>
</head>

<body class="sb-nav-fixed">
    <!-- Navigation Bar -->
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand ps-3" href="<%= request.getContextPath() %>/home.jsp">PortERP</a>
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

        <!-- Main Content Area -->
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Track Your Orders</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="consumer_dashboard.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item active"><a href="trackOrder.jsp">Orders</a></li>
                        <li class="breadcrumb-item active">Order status</li>
                    </ol>

                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-shipping-fast"></i> Order #<%= currentOrder.getOrder_id() %>
                        </div>
                        <div class="card-body">
                            <h5>Track Order Status</h5>
                            <div class="progress-container">
                                <div class="progress-bar">
                                    <div class="progress-bar-fill" style="<%= progressStyle %>"></div>
                                </div>
                                <div class="progress-checkpoints">
                                    <div class="checkpoint <%= currentOrder.isOrder_placed() ? "completed" : "incomplete" %>">
                                        <div class="circle"><i class="fas fa-box"></i></div>
                                        <span>Order Placed</span>
                                    </div>
                                    <div class="checkpoint <%= currentOrder.isShipped() ? "completed" : "incomplete" %>">
                                        <div class="circle"><i class="fas fa-truck"></i></div>
                                        <span>Shipped</span>
                                    </div>
                                    <div class="checkpoint <%= currentOrder.isOut_for_delivery() ? "completed" : "incomplete" %>">
                                        <div class="circle"><i class="fas fa-box-open"></i></div>
                                        <span>Out for Delivery</span>
                                    </div>
                                    <div class="checkpoint <%= currentOrder.isDelivered() ? "completed" : "incomplete" %>">
                                        <div class="circle"><i class="fas fa-check-circle"></i></div>
                                        <span>Delivered</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="<%= request.getContextPath() %>/js/scripts.js"></script>
</body>
</html>