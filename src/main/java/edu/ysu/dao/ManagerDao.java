package edu.ysu.dao;

import edu.ysu.entity.Manager;

public interface ManagerDao {

	public Manager getByUserName(String userName);
}
