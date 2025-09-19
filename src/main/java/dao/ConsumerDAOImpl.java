package dao;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import daointerfaces.*;
import jdbc.GetConnection;
import models.ConsumerPojo;
import utilities.Utils;

public class ConsumerDAOImpl implements ConsumerDAO {
    CallableStatement callableStatement = null;
    ResultSet resultSet = null;

    @Override
    public void registerConsumer(ConsumerPojo consumerPojo) throws SQLException {
        try {
			callableStatement = GetConnection.connect().prepareCall("CALL RegisterConsumer(?,?,?)");
	        callableStatement.setString(1, consumerPojo.getPort_name());
	        callableStatement.setString(2, consumerPojo.getCon_password());
	        callableStatement.setString(3, consumerPojo.getLocation());
	        callableStatement.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }


    @Override
    public boolean loginConsumer(ConsumerPojo consumerPojo) throws SQLException {

        boolean authStatus = false;
        try {
			callableStatement = GetConnection.connect().prepareCall("CALL Login(?,?)");
			callableStatement.setString(1, consumerPojo.getPort_name());
		        callableStatement.setString(2, consumerPojo.getRole());
		        resultSet = callableStatement.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 
        try {
   		if (resultSet.next()) {
   			String storedHash = resultSet.getString("password"); // Fetch the login status message
		    
		    // Determine success based on the returned message
		    authStatus = Utils.checkHash(consumerPojo.getCon_password(), storedHash);
   		}
   	} catch (SQLException e) {
   		// TODO Auto-generated catch block
   		e.printStackTrace();
   	}
       return authStatus;
    }

    @Override
    public String updateProfile(ConsumerPojo consumerPojo, String newPassword) {
        String result;
        try {
            callableStatement = GetConnection.connect().prepareCall("CALL UpdateProfile(?, ?, ?,?)"); // Updated for procedure
            callableStatement.setInt(1, consumerPojo.getCon_port_id());
            callableStatement.setString(2, consumerPojo.getCon_password()); // Current password for verification
            callableStatement.setString(3, newPassword); // New password
            callableStatement.setString(4, consumerPojo.getLocation());
            callableStatement.execute();
            result = "success"; // If no exception, update is successful
        } catch (SQLException e) {
            // Check for specific error messages to return
            if (e.getMessage().contains("Incorrect current password")) {
                result = "Incorrect current password. Please try again.";
            } else {
                result = "An error occurred while updating your profile. Please try again.";
            }
            e.printStackTrace();
        } catch (IOException e) {
            result = "An error occurred during input/output operations.";
            e.printStackTrace();
        }
        return result; // Return status message
    }

    
    @Override
    public String getConsumerLocation(int portId) {
    	String location = null;
    	try {
			callableStatement =GetConnection.connect().prepareCall("SELECT location from consumer_port where port_id = ?");
	    	callableStatement.setInt(1, portId);
	    	resultSet = callableStatement.executeQuery();
	    	
	    	while(resultSet.next()) {
	    		location = resultSet.getString("location");
	    	}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return location;

    	
    	
    }


    @Override
	public void deleteConsumer(int portId) {
		// TODO Auto-generated method stub
    	
    	try {
			callableStatement = GetConnection.connect().prepareCall("CALL DeleteConsumer(?)");
			callableStatement.setInt(1, portId);
			callableStatement.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
		
	}

  



}