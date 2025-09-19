package interfaces;
import models.ConsumerPojo;


public interface Consumer {

	void RegisterConsumer(ConsumerPojo consumerPojo);

	public boolean LoginConsumer(ConsumerPojo consumerPojo);

	String updateProfile(ConsumerPojo consumerPojo, String newPassword);
	
	public String getConsumerLocation(int portId) ;

	void deleteConsumer(int portId);

//	void CancelOrder(OrdersPojo ordersPojo);

}