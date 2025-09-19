package models;

import java.util.Date;
import java.util.List;

import implementors.OrdersImplementor;


public class OrdersPojo {

	private int order_id;
	private int product_id;
	private int consumer_port_id;
	private int quantity;
	private Date order_date;
	private boolean order_placed;
	private boolean shipped;
	private boolean out_for_delivery;
	private boolean delivered;
	private String new_status;

	public int getOrder_id() {
		return order_id;
	}

	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getConsumer_port_id() {
		return consumer_port_id;
	}

	public void setConsumer_port_id(int consumer_port_id) {
		this.consumer_port_id = consumer_port_id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public void setOrder_placed(boolean order_placed) {
		this.order_placed = order_placed;
	}
	
	public boolean isOrder_placed() {
		return order_placed;
	}

	public boolean isShipped() {
		return shipped;
	}

	public void setShipped(boolean shipped) {
		this.shipped = shipped;
	}

	public boolean isOut_for_delivery() {
		return out_for_delivery;
	}

	public void setOut_for_delivery(boolean out_for_delivery) {
		this.out_for_delivery = out_for_delivery;
	}

	public boolean isDelivered() {
		return delivered;
	}

	public void setDelivered(boolean delivered) {
		this.delivered = delivered;
	}

	public String getNew_status() {
		return new_status;
	}

	public void setNew_status(String new_status) {
		this.new_status = new_status;
	}

	
	public List<OrdersPojo> viewOrders(int seller_id) {
		return new OrdersImplementor().viewOrders(seller_id); 
		// TODO Auto-generated method stub

	}
	
	
	public void PlaceOrder(OrdersPojo ordersPojo) {
		// TODO Auto-generated method stub
		new OrdersImplementor().PlaceOrder(ordersPojo);

	}
	
	public List<OrdersPojo> viewOrdersConsumer(int port_id){
		return new OrdersImplementor().viewOrdersConsumer(port_id);
		
		
	}
}