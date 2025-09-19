package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.ProductsPojo;
import implementors.ProductsImplementor;

/**
 * Servlet implementation class ProductsServlet
 */
@WebServlet("/ProductsServlet")
public class ProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Instance of the service class to handle business logic


    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve action from request
        String action = request.getParameter("action");
        String role = request.getParameter("role");
        
        if (action == null) {
            response.sendRedirect("Products-Management.jsp");
            return;
        } else if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("update".equals(action)) {
            updateProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        } else if ("viewProducts".equals(action)) { // Handling viewProducts action
        	if("Consumer".equals(role)) {
                viewProductsConsumer(request, response);
        	}
        	else {
        		viewProducts(request, response);
        	}

        } else {
            response.sendRedirect("Products-Management.jsp");
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get product details from request
        int productId = Integer.parseInt(request.getParameter("product_id"));
        String productName = request.getParameter("product_name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        float price = Float.parseFloat(request.getParameter("price"));
        HttpSession session = request.getSession(false);  // Get the existing session, do not create a new one
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");  // Redirect if no session exists
            return;
        }
        int seller_id = (int) session.getAttribute("userId");

        // Create and set product data
        ProductsPojo product = new ProductsPojo();
        product.setProduct_id(productId);
        product.setProduct_name(productName);
        product.setQuantity(quantity);
        product.setPrice(price);
        product.setSeller_id(seller_id);

        // Call service to add product
        ProductsImplementor productsImplementor = new ProductsImplementor();

        productsImplementor.AddProduct(product); 

        // Redirect back to the management page after adding the product
        response.sendRedirect("ProductsServlet?action=viewProducts");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get product details from request
        int productId = Integer.parseInt(request.getParameter("product_id"));
        String productName = request.getParameter("product_name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        float price = Float.parseFloat(request.getParameter("price"));

        // Create and set product data
        ProductsPojo product = new ProductsPojo();
        product.setProduct_id(productId);
        product.setProduct_name(productName);
        product.setQuantity(quantity);
        product.setPrice(price);

        // Call service to update product details
        ProductsImplementor productsImplementor = new ProductsImplementor();

        productsImplementor.updateProductDetails(product); 

        // Redirect back to the management page after updating
        response.sendRedirect("ProductsServlet?action=viewProducts");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get product id from request
        int productId = Integer.parseInt(request.getParameter("product_id"));

        // Create a product object with the id
        ProductsPojo product = new ProductsPojo();
        product.setProduct_id(productId);

        // Call service to delete the product
        ProductsImplementor productsImplementor = new ProductsImplementor();

        productsImplementor.DeleteProduct(product);; 

        // Redirect back to the management page after deleting
        response.sendRedirect("ProductsServlet?action=viewProducts");
    }

    private void viewProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the list of products
    	ProductsPojo ProductsPojo = new ProductsPojo();
    	  ProductsImplementor productsImplementor = new ProductsImplementor();

        List<ProductsPojo> productList = productsImplementor.viewProducts(ProductsPojo) ;

        // Set the product list in request attribute
        request.setAttribute("productList", productList);

        // Forward to the product management page
        request.getRequestDispatcher("Products-Management.jsp").forward(request, response);
    }

    private void viewProductsConsumer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	ProductsPojo ProductsPojo = new ProductsPojo();
  	  ProductsImplementor productsImplementor = new ProductsImplementor();

      List<ProductsPojo> productList = productsImplementor.viewProducts(ProductsPojo) ;

      // Set the product list in request attribute
      request.setAttribute("productList", productList);

      // Forward to the product management page
      request.getRequestDispatcher("consumerProducts.jsp").forward(request, response);

	}
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}