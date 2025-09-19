package implementors;

import java.util.List;

import dao.OrdersDAOImpl;
import interfaces.Orders;
import models.OrdersPojo;

public class OrdersImplementor implements Orders{

	@Override
	public List<OrdersPojo> viewOrders(int seller_id) {

		// TODO Auto-generated method stub
		return new OrdersDAOImpl().viewOrders(seller_id);
	}
	

	public void PlaceOrder(OrdersPojo ordersPojo) {
		// TODO Auto-generated method stub
		new OrdersDAOImpl().PlaceOrder(ordersPojo);
		
	}

	public List<OrdersPojo> viewOrdersConsumer(int port_id) {
		// TODO Auto-generated method stub
		return new OrdersDAOImpl().viewOrdersConsumer(port_id);
	}
	
	public void updateOrderStatus(int orderId, String newStatus) {
		new OrdersDAOImpl().updateOrderStatus(orderId, newStatus);
	}


}