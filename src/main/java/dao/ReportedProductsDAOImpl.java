package dao;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import daointerfaces.ReportedProductsDAO;
import jdbc.GetConnection;
import models.ReportedProductsPojo;

public class ReportedProductsDAOImpl implements ReportedProductsDAO {
CallableStatement callableStatement = null;

    @Override
    public List<ReportedProductsPojo> viewIssues() {
        List<ReportedProductsPojo> reportList = new ArrayList<ReportedProductsPojo>();

        ResultSet resultSet = null;
        try  {
			try {
				callableStatement = GetConnection.connect().prepareCall("CALL ViewIssues()");
	            resultSet = callableStatement.executeQuery();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}


            while (resultSet.next()) {
                ReportedProductsPojo reportedProductsPojo = new ReportedProductsPojo();
                reportedProductsPojo.setReport_id(resultSet.getString("report_id"));
                reportedProductsPojo.setConsumer_port_id(resultSet.getInt("consumer_port_id"));
                reportedProductsPojo.setProduct_id(resultSet.getInt("product_id"));
                reportedProductsPojo.setIssue_type(resultSet.getString("issue_type"));
                reportedProductsPojo.setSolution(resultSet.getString("solution"));
                reportedProductsPojo.setReport_date(resultSet.getDate("report_date"));
                reportList.add(reportedProductsPojo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reportList;
    }

    public void ReportIssue(ReportedProductsPojo productsPojo) {
        try {
			callableStatement = GetConnection.connect().prepareCall("CALL ReportIssue(?,?,?)");
	        callableStatement.setInt(1, productsPojo.getConsumer_port_id());
	        callableStatement.setInt(2, productsPojo.getProduct_id());
	        callableStatement.setString(3, productsPojo.getIssue_type());
	        callableStatement.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

    }

}