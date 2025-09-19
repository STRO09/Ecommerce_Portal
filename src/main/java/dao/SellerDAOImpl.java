package dao;

import jdbc.GetConnection;

import models.SellerPojo;
import utilities.Utils;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import daointerfaces.SellerDAO;

public class SellerDAOImpl implements SellerDAO {
	CallableStatement callableStatement = null;
    @Override
    public void registerSeller(SellerPojo sellerPojo)  {
        try  {
			try {
				callableStatement = GetConnection.connect().prepareCall("CALL RegisterSeller(?,?)");
	            callableStatement.setString(1, sellerPojo.getPort_name());
	            callableStatement.setString(2, sellerPojo.getPassword());
	            callableStatement.execute();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}


        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean loginSeller(SellerPojo sellerPojo) {
        boolean authStatus = false;
        ResultSet rs = null;

        try {
        	CallableStatement callableStatement;
			try {
				callableStatement = GetConnection.connect().prepareCall("CALL Login(?,?)");
				callableStatement.setString(1, sellerPojo.getPort_name());
	            callableStatement.setString(2, sellerPojo.getRole());
	            rs = callableStatement.executeQuery();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
			if (rs.next()) {
			    String storedHash = rs.getString("password"); // Fetch the login status message
			    
			    // Determine success based on the returned message
			    authStatus = Utils.checkHash(sellerPojo.getPassword(), storedHash);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return authStatus;
    }

   
    
  
   

	}

   