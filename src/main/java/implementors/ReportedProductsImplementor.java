package implementors;

import java.util.List;

import dao.ReportedProductsDAOImpl;
import interfaces.ReportedProducts;
import models.ReportedProductsPojo;

public class ReportedProductsImplementor implements ReportedProducts{

	@Override
	public List<ReportedProductsPojo> viewIssues(ReportedProductsPojo reportedProductsPojo) {
		// TODO Auto-generated method stub
		return new ReportedProductsDAOImpl().viewIssues(); 
	}


	@Override
	public void ReportIssue(ReportedProductsPojo reportedProductsPojo) {
		// TODO Auto-generated method stub
		new ReportedProductsDAOImpl().ReportIssue(reportedProductsPojo);
		
	}

}