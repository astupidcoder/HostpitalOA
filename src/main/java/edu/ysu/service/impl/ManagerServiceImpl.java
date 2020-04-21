package edu.ysu.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import edu.ysu.dao.ManagerDao;
import edu.ysu.entity.Manager;
import edu.ysu.service.ManagerService;

@Service("managerService")
public class ManagerServiceImpl implements ManagerService{

	@Resource
	private ManagerDao managerDao;
	@Override
	public Manager getByUserName(String userName) {

		return managerDao.getByUserName(userName);
		
	}

	
}
