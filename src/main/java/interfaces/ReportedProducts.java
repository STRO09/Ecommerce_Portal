package interfaces;

import java.util.List;

import models.ReportedProductsPojo;

public interface ReportedProducts {


	public List<ReportedProductsPojo> viewIssues(ReportedProductsPojo reportedProductsPojo);
	
	public void ReportIssue(ReportedProductsPojo reportedProductsPojo) ;
}