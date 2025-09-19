package dao;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import daointerfaces.ProductDAO;
import jdbc.GetConnection;
import models.ProductsPojo;

public class ProductDAOImpl implements ProductDAO{
CallableStatement callableStatement = null;
	 public void AddProduct(ProductsPojo productsPojo) {
	    	
    	 try  {
 			try {
 				callableStatement = GetConnection.connect().prepareCall("CALL AddProduct(?,?,?,?, ?)");
 		           callableStatement.setInt(1, productsPojo.getProduct_id());
 		           callableStatement.setString(2, productsPojo.getProduct_name());
 		            callableStatement.setInt(3, productsPojo.getQuantity());
 		            callableStatement.setFloat(4, productsPojo.getPrice());
 		            callableStatement.setInt(5, productsPojo.getSeller_id());
 		            callableStatement.execute();
 		            System.out.println("Product Details Updated Successfully");
 			} catch (IOException e) {
 				// TODO Auto-generated catch block
 				e.printStackTrace();
 			}
         } catch (SQLException e) {
             e.printStackTrace();
         }
    }
    @Override
    public void updateProductDetails(ProductsPojo productsPojo) {
        try  {
			try {
				callableStatement = GetConnection.connect().prepareCall("CALL UpdateProduct(?,?,?,?)");
		           callableStatement.setInt(1, productsPojo.getProduct_id());
		           callableStatement.setString(2,productsPojo.getProduct_name());
		            callableStatement.setInt(3, productsPojo.getQuantity());
		            callableStatement.setFloat(4, productsPojo.getPrice());
		            callableStatement.execute();
		            System.out.println("Product Details Updated Successfully");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void DeleteProduct(ProductsPojo productsPojo) {
    	try {
			callableStatement = GetConnection.connect().prepareCall("CALL DeleteProduct(?)");
			callableStatement.setInt(1, productsPojo.getProduct_id());
			callableStatement.execute();
			System.out.println("Product Deleted Successfully");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    @Override
    public List<ProductsPojo> viewProducts() {
        List<ProductsPojo> productList = new ArrayList<ProductsPojo>();

        try {
            try{
            	CallableStatement callableStatement = GetConnection.connect().prepareCall("CALL ViewProducts()");
                ResultSet resultSet = callableStatement.executeQuery();
                while (resultSet.next()) {
                    ProductsPojo productsPojo = new ProductsPojo();
                    productsPojo.setProduct_id(resultSet.getInt("product_id"));
                    productsPojo.setProduct_name(resultSet.getString("product_name"));
                    productsPojo.setQuantity(resultSet.getInt("quantity"));
                    productsPojo.setPrice(resultSet.getFloat("price"));
                    productList.add(productsPojo);
                }
            } catch (SQLException  e) {
                e.printStackTrace();
            }
        }
        catch(IOException e) {
    		e.printStackTrace();
        }


        return productList;
    }

    
    @Override
    public ProductsPojo viewProductDetails(int productId) {
        ProductsPojo product = null;
        
        try {
            // Step 1: Establish a connection and prepare the SQL query
            CallableStatement callableStatement = GetConnection.connect().prepareCall("SELECT * FROM products WHERE product_id = ?");
            callableStatement.setInt(1, productId); // Set the product ID as a parameter

            // Step 2: Execute the query and get the result
            ResultSet resultSet = callableStatement.executeQuery();

            // Step 3: If a record is found, map the result to the ProductsPojo object
            if (resultSet.next()) {
                product = new ProductsPojo();
                product.setProduct_id(resultSet.getInt("product_id"));
                product.setProduct_name(resultSet.getString("product_name"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setPrice(resultSet.getFloat("price"));
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exceptions
        } catch (IOException e) {
            e.printStackTrace(); // Handle connection-related exceptions
        } 

        // Return the found product or null if not found
        return product;
    }

    
    
}