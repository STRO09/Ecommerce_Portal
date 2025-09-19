package dao;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import daointerfaces.OrdersDAO;
import jdbc.GetConnection;
import models.OrdersPojo;

public class OrdersDAOImpl implements OrdersDAO {

	  @Override
	    public List<OrdersPojo> viewOrders(int seller_id) {
	        List<OrdersPojo> ordersList = new ArrayList<OrdersPojo>();

	        ResultSet resultSet = null;
	        try {
	        	CallableStatement callableStatement;
				try {
					callableStatement = GetConnection.connect().prepareCall("CALL ViewOrders(?)");
					callableStatement.setInt(1, seller_id);
		            resultSet = callableStatement.executeQuery();
		            System.out.println(resultSet);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

	            while (resultSet.next()) {
	                OrdersPojo ordersPojo = new OrdersPojo();
	                ordersPojo.setOrder_id(resultSet.getInt("order_id"));
	                ordersPojo.setProduct_id(resultSet.getInt("product_id"));
	                ordersPojo.setConsumer_port_id(resultSet.getInt("consumer_port_id"));
	                ordersPojo.setQuantity(resultSet.getInt("Quantity"));
	                ordersPojo.setOrder_date(resultSet.getDate("order_date"));
	                ordersPojo.setOrder_placed(resultSet.getBoolean("order_placed"));
	                ordersPojo.setShipped(resultSet.getBoolean("Shipped"));
	                ordersPojo.setOut_for_delivery(resultSet.getBoolean("out_for_delivery"));
	                ordersPojo.setDelivered(resultSet.getBoolean("Delivered"));
	                ordersList.add(ordersPojo);
	                System.out.println("3"+ordersList);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return ordersList;
	    }
	  
	  @Override
	    public void updateOrderStatus(int orderId, String newStatus) {
	        try  {
	        	CallableStatement callableStatement=null;
				try {
					callableStatement = GetConnection.connect().prepareCall("CALL UpdateOrderStatus(?,?)");
		            callableStatement.setInt(1, orderId);
		            callableStatement.setString(2, newStatus);
		            callableStatement.execute();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	  @Override
	    public void PlaceOrder(OrdersPojo ordersPojo) {
		  CallableStatement callableStatement =null;
	        try {
				callableStatement = GetConnection.connect().prepareCall("CALL PlaceOrder(?,?,?)");
		        callableStatement.setInt(1, ordersPojo.getConsumer_port_id());
		        callableStatement.setInt(2, ordersPojo.getProduct_id());
		        callableStatement.setInt(3, ordersPojo.getQuantity());
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
	    public List<OrdersPojo> viewOrdersConsumer(int port_id) {
	        List<OrdersPojo> ordersPojoslist = new ArrayList<OrdersPojo>();
	        CallableStatement callableStatement =null;
	        ResultSet resultSet =null;
	        try {
				callableStatement = GetConnection.connect().prepareCall("CALL ViewOrdersConsumer(?)");
				callableStatement.setInt(1, port_id);
		        resultSet = callableStatement.executeQuery();

		        while (resultSet.next()) {
		            OrdersPojo ordersPojo1 = new OrdersPojo();
		            ordersPojo1.setOrder_id(resultSet.getInt("order_id"));
		            ordersPojo1.setProduct_id(resultSet.getInt("product_id"));
		            ordersPojo1.setConsumer_port_id(resultSet.getInt("consumer_port_id"));
		            ordersPojo1.setQuantity(resultSet.getInt("Quantity"));
		            ordersPojo1.setOrder_date(resultSet.getDate("order_date"));
		            ordersPojo1.setOrder_placed(resultSet.getBoolean("order_placed"));
		            ordersPojo1.setShipped(resultSet.getBoolean("Shipped"));
		            ordersPojo1.setOut_for_delivery(resultSet.getBoolean("out_for_delivery"));
		            ordersPojo1.setDelivered(resultSet.getBoolean("Delivered"));
		            ordersPojoslist.add(ordersPojo1);
		        }

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}


	        return ordersPojoslist;
	    }
	}