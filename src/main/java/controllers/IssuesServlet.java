package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import implementors.ReportedProductsImplementor;
import models.ReportedProductsPojo;

/**
 * Servlet implementation class IssuesServlet
 */
@WebServlet("/IssuesServlet")
public class IssuesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
        System.out.println(action);
        if (action == null) {
            response.sendRedirect("ReportedProducts.jsp");
        } else if ("viewIssues".equals(action)) {
            viewIssues(request, response);
        }
        else if("reportIssue".equals(action))
        {
        	reportIssue(request,response);
        }
        
        else {
            response.sendRedirect("ReportedProducts.jsp");
        }
        
        
    }
	
	private void viewIssues(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
        
        ReportedProductsPojo reportedProductsPojo = new ReportedProductsPojo();
        ReportedProductsImplementor reportedProductsImplementor = new ReportedProductsImplementor();
        
        // Fetch the list of orders from the SellerImplementor
        List<ReportedProductsPojo> reportList = reportedProductsImplementor.viewIssues(reportedProductsPojo); 
        
        for (ReportedProductsPojo report : reportList) {
            if (report.getStatus() == null || report.getStatus().isEmpty()) {
                report.setStatus("Pending");
            }
        }
        System.out.println("1"+reportList);
        
        // Set the order list in request attribute to be used in JSP
        request.setAttribute("reportList", reportList);
        
        // Forward the request to the JSP page for displaying orders
        request.getRequestDispatcher("ReportedProducts.jsp").forward(request, response);
	}
	
	private void reportIssue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		int productId = Integer.parseInt(request.getParameter("product_id"));
        String issuetype = request.getParameter("issue_type");
        int consumerportid = Integer.parseInt(request.getParameter("con_port_id")) ;

        // Create and set product data
        ReportedProductsPojo reportedProductsPojo = new ReportedProductsPojo();
        reportedProductsPojo.setProduct_id(productId);
        reportedProductsPojo.setIssue_type(issuetype);
        reportedProductsPojo.setConsumer_port_id(consumerportid);
        

        // Call service to add product
        ReportedProductsImplementor reportedProductsImplementor =new ReportedProductsImplementor();
        boolean isReported = false;
        try{reportedProductsImplementor.ReportIssue(reportedProductsPojo);
        isReported = true;
        		}
        catch(Exception e){ isReported = false;}

        // Redirect back to the management page after adding the product
        
        if (isReported) {
            // If issue reported successfully, set a message and redirect to consumer dashboard
            request.getSession().setAttribute("message", "Product issue reported successfully!");
            response.sendRedirect("consumer_dashboard.jsp");
        } else {
            // Handle failure (optional)
            request.getSession().setAttribute("message", "Failed to report the issue, please try again.");
            response.sendRedirect("reportIssue.jsp");
        }
		
	}
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	}