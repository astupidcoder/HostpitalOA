package edu.ysu.dao;

import java.util.List;
import java.util.Map;

import edu.ysu.entity.Log;

public interface LogDao {

	public Integer add(Log log);
	public List<Log> list(Map<String,Object> map);
	public Integer count(Map<String,Object> map);
	public Log getLogById(Integer id);
}
