package edu.ysu.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import edu.ysu.dao.AppointDao;
import edu.ysu.entity.Appoint;
import edu.ysu.service.AppointService;

@Service("appointService")
public class AppointServiceImpl implements AppointService{

	@Resource
	private AppointDao appointDao;
	@Override
	public Integer add(Appoint appoint) {
		// TODO Auto-generated method stub
		return appointDao.add(appoint);
	}
	@Override
	public Integer update(Appoint appoint) {
		// TODO Auto-generated method stub
		return appointDao.update(appoint);
	}
	@Override
	public Appoint getDoctorByUserNo(String userNo) {
		// TODO Auto-generated method stub
		return appointDao.getDoctorByUserNo(userNo);
	}
	@Override
	public List<Appoint> getPatientByUserNo(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return appointDao.getPatientByUserNo(map);
	}
	@Override
	public Integer countPatient(String userNo) {
		// TODO Auto-generated method stub
		return appointDao.countPatient(userNo);
	}

}
