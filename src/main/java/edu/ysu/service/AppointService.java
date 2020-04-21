package edu.ysu.service;

import java.util.List;
import java.util.Map;

import edu.ysu.entity.Appoint;

public interface AppointService {

	public Integer add(Appoint appoint);
	public Integer update(Appoint appoint);
	public Appoint getDoctorByUserNo(String userNo);
	public List<Appoint> getPatientByUserNo(Map<String,Object> map);
	public Integer countPatient(String userNo);
}
