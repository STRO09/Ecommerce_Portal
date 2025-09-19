package daointerfaces;

import java.util.List;

import models.ProductsPojo;

public interface ProductDAO {

	void updateProductDetails(ProductsPojo productsPojo);
    public void DeleteProduct(ProductsPojo productsPojo);
    public void AddProduct(ProductsPojo productsPojo);
    List<ProductsPojo> viewProducts();
    public ProductsPojo viewProductDetails(int productId);
}