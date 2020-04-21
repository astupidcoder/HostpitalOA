package edu.ysu.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import edu.ysu.dao.LogDao;
import edu.ysu.entity.Log;
import edu.ysu.service.LogService;

@Service("logService")
public class LogServiceImpl implements LogService{

	@Resource
	private LogDao logDao;
	@Override
	public Integer add(Log log) {
		return logDao.add(log);
	}
	@Override
	public List<Log> list(Map<String, Object> map) {
		return logDao.list(map);
	}
	@Override
	public Integer count(Map<String, Object> map) {
		return logDao.count(map);
	}
	@Override
	public Log getLogById(Integer id) {
		// TODO Auto-generated method stub
		return logDao.getLogById(id);
	}

}
