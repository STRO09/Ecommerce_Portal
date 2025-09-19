package daointerfaces;

import java.util.List;

import models.ReportedProductsPojo;

public interface ReportedProductsDAO {


    List<ReportedProductsPojo> viewIssues();
    public void ReportIssue(ReportedProductsPojo reportedProductsPojo) ;
}