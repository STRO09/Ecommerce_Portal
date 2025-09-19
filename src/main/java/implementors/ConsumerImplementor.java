package implementors;


import java.sql.SQLException;



import dao.ConsumerDAOImpl;

import models.ConsumerPojo;
import interfaces.Consumer;

public class ConsumerImplementor implements Consumer {

    @Override
    public void RegisterConsumer(ConsumerPojo consumerPojo) {
    	try {
			new ConsumerDAOImpl().registerConsumer(consumerPojo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    @Override
    public boolean LoginConsumer(ConsumerPojo consumerPojo) {

    	try {
			return new ConsumerDAOImpl().loginConsumer(consumerPojo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
    }

    @Override
    public String updateProfile(ConsumerPojo consumerPojo, String newPassword) {

    	return new ConsumerDAOImpl().updateProfile(consumerPojo,newPassword);
    }

    @Override
    public String getConsumerLocation(int portId) {
    	return new ConsumerDAOImpl().getConsumerLocation(portId);
    }
    
    @Override
    public void deleteConsumer(int portId) {
    	new ConsumerDAOImpl().deleteConsumer(portId);
    }
  
}