package implementors;

import java.util.List;

import dao.ProductDAOImpl;
import interfaces.Products;
import models.ProductsPojo;

public class ProductsImplementor implements Products {

	public void AddProduct(ProductsPojo productsPojo) {
		
		new ProductDAOImpl().AddProduct(productsPojo);
	}
	@Override
	public void updateProductDetails(ProductsPojo productsPojo) {
		// TODO Auto-generated method stub
		new ProductDAOImpl().updateProductDetails(productsPojo); 
		
	}

	@Override
	public List<ProductsPojo> viewProducts(ProductsPojo productsPojo) {
		// TODO Auto-generated method stub
		
		return new ProductDAOImpl().viewProducts(); 
	}
	
	@Override
	public void DeleteProduct(ProductsPojo productsPojo) {
		new ProductDAOImpl().DeleteProduct(productsPojo); 
	}
	
	@Override
	public ProductsPojo viewProductDetails(int productId) {
	    return new ProductDAOImpl().viewProductDetails(productId);
	}

}