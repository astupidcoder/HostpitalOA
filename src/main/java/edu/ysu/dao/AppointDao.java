package edu.ysu.dao;

import java.util.List;
import java.util.Map;

import edu.ysu.entity.Appoint;

public interface AppointDao {

	public Integer add(Appoint appoint);
	public Integer update(Appoint appoint);
	public Appoint getDoctorByUserNo(String userNo);
	public List<Appoint> getPatientByUserNo(Map<String,Object> map);
	public Integer countPatient(String userNo);//计算医生对应病人的数量
}
