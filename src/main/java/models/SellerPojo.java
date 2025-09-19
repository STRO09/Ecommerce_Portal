package models;

import implementors.SellerImplementor;

public class SellerPojo {
	private int sel_port_id;
	private String port_name;
	private String sel_password;
	private String role;

	public int getPort_id() {
		return sel_port_id;
	}

	public void setPort_id(int port_id) {
		this.sel_port_id = port_id;
	}

	public String getPort_name() {
		return port_name;
	}

	public void setPort_name(String port_name) {
		this.port_name = port_name;
	}

	public String getPassword() {
		return sel_password;
	}

	public void setPassword(String password) {
		this.sel_password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	public void RegisterSeller(SellerPojo sellerPojo) {
		// TODO Auto-generated method stub
		new SellerImplementor().RegisterSeller(sellerPojo);

	}
	
	public boolean LoginSeller(SellerPojo sellerPojo) {
		return new SellerImplementor().LoginSeller(sellerPojo);
	}
}