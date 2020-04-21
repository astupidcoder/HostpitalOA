package edu.ysu.service;

import java.util.List;
import java.util.Map;

import edu.ysu.entity.MedicaInfo;

public interface MedicaService {

	public List<MedicaInfo> list(Map<String,Object> map);
	public Integer count(Map<String,Object> map);
	public Integer delete(Map<String,Object> map);
}
