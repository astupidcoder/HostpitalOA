package edu.ysu.dao;

import edu.ysu.entity.Patient;

public interface PatientDao {

	public Patient getByUserNo(String userNo);
}
