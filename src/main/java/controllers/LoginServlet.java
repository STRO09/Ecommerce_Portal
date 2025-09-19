package controllers;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jdbc.GetConnection;
import models.ConsumerPojo;
import models.SellerPojo;
import utilities.Utils;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    ConsumerPojo consumerPojo = new ConsumerPojo();
    SellerPojo sellerPojo = new SellerPojo();
    HttpSession session = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role");
        String portname = request.getParameter("portname");
        String pass = request.getParameter("password");

        System.out.println("Role: " + role);
        System.out.println("Port ID: " + portname);
        System.out.println("Password: " + Utils.HashPass(pass));

        // Handle consumer login
        if ("Consumer".equals(role)) {
            consumerPojo.setPort_name(portname);
            consumerPojo.setCon_password(pass);
            consumerPojo.setRole(role);
            boolean auth_status = consumerPojo.LoginConsumer(consumerPojo);
            System.out.println("Consumer Auth Status: " + auth_status);
            

            if (auth_status) {
                session = request.getSession(); // Get or create a session
                
                try {
    				PreparedStatement ps = GetConnection.connect().prepareStatement("SELECT * FROM CONSUMER_PORT WHERE port_name =?");
    				ps.setString(1, portname);
    				ResultSet resultSet =  ps.executeQuery();
    				if(resultSet.next()) {
    					int portId = resultSet.getInt("port_id"); // fetch port_id
    					String location = resultSet.getString("location");
    					session.setAttribute("userId", portId);
    					session.setAttribute("location", location);
    				}
    			} catch (SQLException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			} catch (IOException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
                session.setAttribute("username", portname);
                session.setAttribute("role", role);

                session.setMaxInactiveInterval(60 * 60); // Set session timeout
                System.out.println("Session ID: " + session.getId());
                System.out.println("User ID in session: " + session.getAttribute("userId"));
                System.out.println("Role in session: " + session.getAttribute("role"));
                response.sendRedirect("consumer_dashboard.jsp");
            } else {
                request.setAttribute("message", "Invalid Port ID, Password, or Role.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } 
        // Handle seller login
        else if ("Seller".equals(role)) {
            sellerPojo.setPort_name(portname);;
            sellerPojo.setPassword(pass);
            sellerPojo.setRole(role);
            boolean auth_status = sellerPojo.LoginSeller(sellerPojo);
            System.out.println("Seller Auth Status: " + auth_status);

            if (auth_status) {
                session = request.getSession(); // Get or create a session
                try {
    				PreparedStatement ps = GetConnection.connect().prepareStatement("SELECT * FROM SELLER_PORT WHERE port_name =?");
    				ps.setString(1, portname);
    				ResultSet resultSet =  ps.executeQuery();
    				if(resultSet.next()) {
    					int portId = resultSet.getInt("port_id"); // fetch port_id
    					session.setAttribute("userId", portId);
    				}
    			} catch (SQLException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			} catch (IOException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
                session.setAttribute("username", portname);
                session.setAttribute("role", role);
                session.setMaxInactiveInterval(60 * 60); // Set session timeout
                System.out.println("Session ID: " + session.getId());
                System.out.println("User ID in session: " + session.getAttribute("userId"));
                System.out.println("Role in session: " + session.getAttribute("role"));
                response.sendRedirect("seller-dashboard.jsp");
            } else {
                request.setAttribute("message", "Invalid Port ID, Password, or Role.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } 
        // Invalid role handling
        else {
            request.setAttribute("message", "Invalid Role selected.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}