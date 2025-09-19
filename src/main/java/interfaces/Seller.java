package interfaces;

import models.SellerPojo;


public interface Seller {
	void RegisterSeller(SellerPojo sellerPojo);

	public boolean LoginSeller(SellerPojo sellerPojo);


}