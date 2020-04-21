package edu.ysu.dao;

import java.util.List;
import java.util.Map;

import edu.ysu.entity.Office;

public interface OfficeDao {

	public List<Office> list(Map<String,Object> map);
	public Integer count(Map<String,Object> map);
	public Office findByNo(String officeNo);
	public Integer add(Office office);
	public Integer update(Office office);
	public Integer delete(Map<String,Object> map);
	public List<Office> search(Map<String,Object> map);
}
