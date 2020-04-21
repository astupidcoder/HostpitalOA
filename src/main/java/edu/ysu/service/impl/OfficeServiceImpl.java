package edu.ysu.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import edu.ysu.dao.OfficeDao;
import edu.ysu.entity.Office;
import edu.ysu.service.OfficeService;

@Service("officeService")
public class OfficeServiceImpl implements OfficeService{

	@Resource
	private OfficeDao officeDao;
	@Override
	public List<Office> list(Map<String,Object> map) {
		return officeDao.list(map);
	}
	@Override
	public Integer count(Map<String,Object> map) {
		return officeDao.count(map);
	}
	@Override
	public Office findByNo(String officeNo) {
		return officeDao.findByNo(officeNo);
	}
	@Override
	public Integer add(Office office) {
		return officeDao.add(office);
	}
	@Override
	public Integer update(Office office) {
		return officeDao.update(office);
	}
	@Override
	public Integer delete(Map<String,Object> map) {
		return officeDao.delete(map);
	}
	@Override
	public List<Office> search(Map<String, Object> map) {
		return officeDao.search(map);
	}

}
