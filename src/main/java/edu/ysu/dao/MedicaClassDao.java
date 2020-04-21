package edu.ysu.dao;

import java.util.Map;

import edu.ysu.entity.MedicaClass;

public interface MedicaClassDao {

	public MedicaClass findById(Map<String,Object> map);
}
