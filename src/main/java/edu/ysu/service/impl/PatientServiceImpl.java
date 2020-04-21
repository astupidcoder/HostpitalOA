package edu.ysu.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import edu.ysu.dao.PatientDao;
import edu.ysu.entity.Patient;
import edu.ysu.service.PatientService;

@Service("patientService")
public class PatientServiceImpl implements PatientService{

	@Resource
	private PatientDao patientDao;
	@Override
	public Patient getByUserNo(String userNo) {
		return patientDao.getByUserNo(userNo);
	}

}
