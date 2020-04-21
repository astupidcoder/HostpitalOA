package edu.ysu.dao;

import java.util.List;
import java.util.Map;

import edu.ysu.entity.MedicaInfo;

public interface MedicaDao {

	public List<MedicaInfo> list(Map<String,Object> map);
	public Integer count(Map<String,Object> map);
	public Integer delete(Map<String,Object> map);
}
