package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import implementors.ConsumerImplementor;
import models.ConsumerPojo;

/**
 * Servlet implementation class ConsumerServlet
 */
@WebServlet("/ConsumerServlet")
public class ConsumerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    int portId = Integer.parseInt(request.getParameter("port_id"));
	    String password = request.getParameter("password");
	    String newPassword = request.getParameter("newpassword");
	    String location = request.getParameter("location");

	    // Creating ConsumerPojo with current info
	    ConsumerPojo consumerPojo = new ConsumerPojo();
	    consumerPojo.setCon_port_id(portId);
	    consumerPojo.setCon_password(password); // Current password for verification
	    consumerPojo.setLocation(location);

	    // Call updateProfile to handle password change and location update
	    ConsumerImplementor consumerImplementor = new ConsumerImplementor();
	    String updateStatus = consumerImplementor.updateProfile(consumerPojo, newPassword);

	    if ("success".equals(updateStatus)) {
	    	 request.getSession().setAttribute("successMessage", "Profile updated successfully");
	        response.sendRedirect("consumer_dashboard.jsp"); // Redirect on success
	    } else {
	        request.setAttribute("errorMessage", updateStatus);
	        request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
	    }
	}

}