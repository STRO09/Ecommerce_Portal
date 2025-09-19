package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import implementors.ConsumerImplementor;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    ConsumerImplementor consumerImplementor = new ConsumerImplementor();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Retrieve session if it exists
        
        if (session != null) {
            int userId = (int) session.getAttribute("userId"); // Get userId from session
            
            // Check if delete parameter is set to true
            if ("true".equals(request.getParameter("deleteProfile"))) {
                // Delete the user from the database based on userId
                consumerImplementor.deleteConsumer(userId); // Call the delete method (see below)
                
                // Set a message confirming account deletion
                request.setAttribute("message", "Your account has been successfully deleted.");
                
                // Forward to logout.jsp with the deletion message
                request.getRequestDispatcher("logout.jsp").forward(request, response);
                // Invalidate the session
                session.invalidate();
                return;
            }
            
            // If delete is not requested, perform a regular logout
            request.setAttribute("message", "You have been successfully logged out!");
            request.getRequestDispatcher("logout.jsp").forward(request, response);
            // Invalidate the session
            session.invalidate();
        } else {
            // If no session exists, redirect to login page
            response.sendRedirect("login.jsp");
        }
    }
    
}