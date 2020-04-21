package edu.ysu.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import edu.ysu.dao.MedicaClassDao;
import edu.ysu.entity.MedicaClass;
import edu.ysu.service.MedicaClassService;

@Service("medicaClassService")
public class MedicaClassServiceImpl implements MedicaClassService{

	@Resource
	private MedicaClassDao medicaClassDao;

	@Override
	public MedicaClass findById(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return medicaClassDao.findById(map);
	}
	
	
}
