package daointerfaces;


import models.SellerPojo;

public interface SellerDAO {
    void registerSeller(SellerPojo sellerPojo);
    boolean loginSeller(SellerPojo sellerPojo);

}