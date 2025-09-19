package interfaces;

import java.util.List;

import models.OrdersPojo;

public interface Orders {

	public List<OrdersPojo> viewOrders(int seller_id);
	
	public void PlaceOrder(OrdersPojo ordersPojo);
	
	public List<OrdersPojo> viewOrdersConsumer(int port_id);
}