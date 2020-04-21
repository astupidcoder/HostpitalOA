package edu.ysu.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import edu.ysu.dao.MedicaDao;
import edu.ysu.entity.MedicaInfo;
import edu.ysu.service.MedicaService;

@Service("medicaService")
public class MedicaServiceImpl implements MedicaService{

	@Resource
	private MedicaDao medicaDao;
	@Override
	public List<MedicaInfo> list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return medicaDao.list(map);
	}
	@Override
	public Integer count(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return medicaDao.count(map);
	}
	@Override
	public Integer delete(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return medicaDao.delete(map);
	}

}
