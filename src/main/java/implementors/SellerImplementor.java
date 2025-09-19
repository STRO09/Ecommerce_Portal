package implementors;



import dao.SellerDAOImpl;

import interfaces.Seller;

import models.SellerPojo;

public class SellerImplementor implements Seller{

	@Override
	public void RegisterSeller(SellerPojo sellerPojo) {
		// TODO Auto-generated method stub
		new SellerDAOImpl().registerSeller(sellerPojo);

		
	}

	@Override
	public boolean LoginSeller(SellerPojo sellerPojo) {
		// TODO Auto-generated method stub
		return new SellerDAOImpl().loginSeller(sellerPojo);
	}


}