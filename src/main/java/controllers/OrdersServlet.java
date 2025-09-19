package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import implementors.OrdersImplementor;
import models.OrdersPojo;

/**
 * Servlet implementation class OrdersServlet
 */
@WebServlet("/OrdersServlet")
public class OrdersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Handles POST requests.
	 * 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		String role = request.getParameter("role");

		System.out.println(action);
		if (action == null) {
			response.sendRedirect("Products-Management.jsp");
		} else if ("viewOrders".equals(action)) {
			if ("Consumer".equals(role)) {
				viewOrdersConsumer(request, response);
			} else {
				viewOrders(request, response);
			}
		} else if ("UpdateOrderStatus".equals(action)) {
			updateOrderStatus(request, response);
		}

		else if ("placeOrder".equals(action)) {
			PlaceOrder(request, response);
		}

		else if ("trackOrder".equals(action)) {
			TrackOrder(request, response);
		}

		else {
			response.sendRedirect("Products-Management.jsp");
		}
	}

	/**
	 * Handles the viewing of orders by retrieving the order list and forwarding it
	 * to the view.
	 */
	private void viewOrders(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		OrdersPojo ordersPojo = new OrdersPojo(); // Optionally populate OrdersPojo with data if needed
		OrdersImplementor ordersImplementor = new OrdersImplementor();
		HttpSession session = request.getSession(false); // Get the existing session, do not create a new one
		if (session == null || session.getAttribute("userId") == null) {
			response.sendRedirect("login.jsp"); // Redirect if no session exists
			return;
		}
		int seller_id = (int) session.getAttribute("userId");

		// Fetch the list of orders from the SellerImplementor
		List<OrdersPojo> ordersList = ordersImplementor.viewOrders(seller_id);

		System.out.println("1" + ordersList);

		// Set the order list in request attribute to be used in JSP
		request.setAttribute("ordersList", ordersList);

		// Forward the request to the JSP page for displaying orders
		request.getRequestDispatcher("OrderedProductsSeller.jsp").forward(request, response);
	}

	private void viewOrdersConsumer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		OrdersImplementor ordersImplementor = new OrdersImplementor();
		HttpSession session = request.getSession(false); // Get the existing session, do not create a new one
		if (session == null || session.getAttribute("userId") == null) {
			response.sendRedirect("login.jsp"); // Redirect if no session exists
			return;
		}
		int con_id = (int) session.getAttribute("userId");

		// Fetch the list of orders from the SellerImplementor
		List<OrdersPojo> ordersList = ordersImplementor.viewOrdersConsumer(con_id);

		System.out.println("1" + ordersList);

		// Set the order list in request attribute to be used in JSP
		request.setAttribute("ordersList", ordersList);

		// Forward the request to the JSP page for displaying orders
		request.getRequestDispatcher("OrderedProductsConsumer.jsp").forward(request, response);
	}

	private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		String newStatus = request.getParameter("newStatus");

		// Update the order status in the database
		OrdersImplementor ordersImplementor = new OrdersImplementor();
		ordersImplementor.updateOrderStatus(orderId, newStatus);

		// Redirect back to the view orders page
		viewOrders(request, response);

	}

	private void PlaceOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int con_port_id = Integer.parseInt(request.getParameter("con_port_id"));
		int product_id = Integer.parseInt(request.getParameter("product_id"));
		int availableQuantity = Integer.parseInt(request.getParameter("available_quantity"));
		int orderQuantity = Integer.parseInt(request.getParameter("quantity"));
		OrdersPojo ordersPojo = new OrdersPojo();

		if (orderQuantity > availableQuantity) {
			// Redirect with error message if order quantity exceeds available quantity
			response.sendRedirect("PlaceOrderForm.jsp?product_id=" + request.getParameter("product_id")
					+ "&product_name=" + request.getParameter("product_name") + "&product_price="
					+ request.getParameter("product_price") + "&available_quantity=" + availableQuantity
					+ "&error=Quantity requested exceeds available stock.");
		} else {
			OrdersImplementor ordersImplementor = new OrdersImplementor();
			ordersPojo.setConsumer_port_id(con_port_id);
			ordersPojo.setProduct_id(product_id);
			ordersPojo.setQuantity(orderQuantity);
			ordersImplementor.PlaceOrder(ordersPojo);

			viewOrdersConsumer(request, response);

		}

	}

	private void TrackOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		OrdersImplementor ordersImplementor = new OrdersImplementor();
		int consumer_id = (int) session.getAttribute("userId");

		// Fetch the list of orders from the SellerImplementor
		List<OrdersPojo> ordersList = ordersImplementor.viewOrdersConsumer(consumer_id);

		System.out.println("1" + ordersList);

		// Set the order list in request attribute to be used in JSP
		request.setAttribute("ordersList", ordersList);

		// Forward the request to the JSP page for displaying orders
		request.getRequestDispatcher("RealOrderTracking.jsp").forward(request, response);

	}

	/**
	 * Handles GET requests by forwarding them to doPost method.
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}