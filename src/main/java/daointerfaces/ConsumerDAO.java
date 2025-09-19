package daointerfaces;

import java.sql.SQLException;

import models.ConsumerPojo;

public interface ConsumerDAO {
    void registerConsumer(ConsumerPojo consumerPojo) throws SQLException;
    boolean loginConsumer(ConsumerPojo consumerPojo) throws SQLException;
    public String updateProfile(ConsumerPojo consumerPojo, String newPassword);
    public String getConsumerLocation(int portId);
	void deleteConsumer(int portId);
}