package interfaces;

import java.util.List;

import models.ProductsPojo;

public interface Products {

	void updateProductDetails(ProductsPojo productsPojo);

	public List<ProductsPojo> viewProducts(ProductsPojo productsPojo);
	
	public void AddProduct(ProductsPojo productsPojo);
	
	public void DeleteProduct(ProductsPojo productsPojo);
	
	public ProductsPojo viewProductDetails(int productId);
}