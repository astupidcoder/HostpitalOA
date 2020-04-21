package edu.ysu.entity;

import java.util.Date;

/**
 * 挂号表
 * @author lyj
 *
 */
public class Appoint {

	private Integer id;
	private Patient patient;
	private Doctor doctor;
	private String status;
	private Date date;
	public Integer getId() {
		return id;
	}
	
  public void setId(Integer id) {
		this.id = id;
	}

  
	public Patient getPatient() {
	return patient;
}

public void setPatient(Patient patient) {
	this.patient = patient;
}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	public Doctor getDoctor() {
		return doctor;
	}

	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}
	


	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Appoint(Patient patient, Doctor doctor, String status) {
		super();
		this.patient = patient;
		this.doctor = doctor;
		this.status = status;
	}

	public Appoint() {
		super();
		// TODO Auto-generated constructor stub
	}
}
