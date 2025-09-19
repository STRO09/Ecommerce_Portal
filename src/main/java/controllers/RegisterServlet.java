package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.ConsumerPojo;
import models.SellerPojo;
import utilities.Utils;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ConsumerPojo consumerPojo = new ConsumerPojo();
	SellerPojo sellerPojo = new SellerPojo();

	/**
	 * Default constructor.
	 */
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String role = request.getParameter("role");
		String portname = request.getParameter("portname");
		String pass = request.getParameter("password");
		System.out.println(role);
		System.out.println(portname);
		System.out.println(Utils.HashPass(pass));

		String confirmPassword = request.getParameter("confirmPassword");

		if (!pass.equals(confirmPassword)) {
			request.setAttribute("message", "Passwords do not match!");
			request.getRequestDispatcher("Register.jsp").forward(request, response);
			return; // Stop further processing
		}

		if ("Consumer".equals(role)) {
			try {
				String location = request.getParameter("location");
				consumerPojo.setPort_name(portname);
				consumerPojo.setCon_password(Utils.HashPass(pass));
				consumerPojo.setLocation(location);
				consumerPojo.setRole(role);
				consumerPojo.RegisterConsumer(consumerPojo);
				System.out.println("Registered successfully");
				response.sendRedirect("login.jsp");
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("message", "Consumer registration failed. Please try again.");
				request.getRequestDispatcher("Register.jsp").forward(request, response);
			}
		} else {
			try {
				sellerPojo.setPort_name(portname);
				sellerPojo.setPassword(Utils.HashPass(pass));
				sellerPojo.setRole(role);
				sellerPojo.RegisterSeller(sellerPojo);
				response.sendRedirect("login.jsp");
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("message", "Seller registration failed. Please try again.");
				request.getRequestDispatcher("Register.jsp").forward(request, response);
			}
		}

	}

}