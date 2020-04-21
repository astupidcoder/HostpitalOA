package edu.ysu.dao;

import java.util.List;
import java.util.Map;

import edu.ysu.entity.Doctor;

public interface DoctorDao {

	public Doctor getByUserNo(String userNo);
	public int update(Doctor doctor);
	public List<Doctor> list(Map<String,Object> map);
	public Integer count(Map<String,Object> map);
	public List<Doctor> search(String doctName);
	public List<Doctor> search2(Map<String,Object> map);
	public Integer add(Doctor doctor);
	public Integer delete(Map<String,Object> map);
}
