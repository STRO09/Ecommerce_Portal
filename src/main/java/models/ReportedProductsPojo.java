package models;

import java.util.Date;
import java.util.List;

import implementors.ReportedProductsImplementor;


public class ReportedProductsPojo {
	private String report_id;
	private int consumer_port_id;
	private int product_id;
	private String issue_type;
	private String solution;
	private Date report_date;
	private String status;

	public String getReport_id() {
		return report_id;
	}

	public void setReport_id(String report_id) {
		this.report_id = report_id;
	}

	public int getConsumer_port_id() {
		return consumer_port_id;
	}

	public void setConsumer_port_id(int consumer_port_id) {
		this.consumer_port_id = consumer_port_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getIssue_type() {
		return issue_type;
	}

	public void setIssue_type(String issue_type) {
		this.issue_type = issue_type;
	}

	public String getSolution() {
		return solution;
	}

	public void setSolution(String solution) {
		this.solution = solution;
	}

	public Date getReport_date() {
		return report_date;
	}

	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	public List<ReportedProductsPojo> viewIssues(ReportedProductsPojo reportedProductsPojo){
		return new ReportedProductsImplementor().viewIssues(reportedProductsPojo);
		
	}

	public void ReportIssue(ReportedProductsPojo reportedProductsPojo) {
		new ReportedProductsImplementor().ReportIssue(reportedProductsPojo);
	}

}