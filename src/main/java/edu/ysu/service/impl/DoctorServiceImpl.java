package edu.ysu.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import edu.ysu.dao.DoctorDao;
import edu.ysu.entity.Doctor;
import edu.ysu.service.DoctorService;

@Service("doctorService")
public class DoctorServiceImpl implements DoctorService{

	@Resource
	private DoctorDao doctorDao;

	@Override
	public Doctor getByUserNo(String userNo) {
		return doctorDao.getByUserNo(userNo);
	}

	@Override
	public int update(Doctor doctor) {
		return doctorDao.update(doctor);
	}

	@Override
	public List<Doctor> list(Map<String,Object> map) {
		return doctorDao.list(map);
	}

	@Override
	public List<Doctor> search(String doctName) {
		// TODO Auto-generated method stub
		return doctorDao.search(doctName);
	}

	@Override
	public Integer count(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return doctorDao.count(map);
	}

	@Override
	public Integer add(Doctor doctor) {
		// TODO Auto-generated method stub
		return doctorDao.add(doctor);
	}

	@Override
	public Integer delete(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return doctorDao.delete(map);
	}

	@Override
	public List<Doctor> search2(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return doctorDao.search2(map);
	}
	

}
