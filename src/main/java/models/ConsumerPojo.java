package models;

import implementors.ConsumerImplementor;

public class ConsumerPojo {
	private int port_id;
	private String port_name;
	private String con_password;
	private String location;
	private String role;

	public int getCon_port_id() {
		return port_id;
	}

	public void setCon_port_id(int con_port_id) {
		this.port_id = con_port_id;
	}
	
	public String getPort_name() {
		return port_name;
	}

	public void setPort_name(String port_name) {
		this.port_name = port_name;
	}

	public String getCon_password() {
		return con_password;
	}

	public void setCon_password(String con_password) {
		this.con_password = con_password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
	
	public void RegisterConsumer(ConsumerPojo consumerPojo) {
		// TODO Auto-generated method stub
		 new ConsumerImplementor().RegisterConsumer(consumerPojo);
	}
	 
	public boolean LoginConsumer(ConsumerPojo consumerPojo) {
		return new ConsumerImplementor().LoginConsumer(consumerPojo);
	}
	 
	public String getConsumerLocation(int portId) {

	    return new ConsumerImplementor().getConsumerLocation(portId);
	}

	
}