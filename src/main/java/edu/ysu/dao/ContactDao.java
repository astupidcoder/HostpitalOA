package edu.ysu.dao;

import java.util.List;
import java.util.Map;

import edu.ysu.entity.Contact;
import edu.ysu.entity.Doctor;

public interface ContactDao {

	public List<Doctor> list(Map<String,Object> map);
	public Integer count(Map<String,Object> map);
	public Integer update(Contact contact);
	public Integer add(Contact contact);
	public Integer delete(Map<String,Object> map);

}
