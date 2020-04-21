package edu.ysu.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import edu.ysu.dao.ContactDao;
import edu.ysu.entity.Contact;
import edu.ysu.entity.Doctor;
import edu.ysu.service.ContactService;


@Service("contactService")
public class ContactServiceImpl implements ContactService{

	@Resource
	private ContactDao contactDao;
	@Override
	public List<Doctor> list(Map<String,Object> map) {
		return contactDao.list(map);
	}
	@Override
	public Integer count(Map<String, Object> map) {
		return contactDao.count(map);
	}
	@Override
	public Integer update(Contact contact) {
		return contactDao.update(contact);
	}
	@Override
	public Integer add(Contact contact) {
		return contactDao.add(contact);
	}
	@Override
	public Integer delete(Map<String,Object> map) {
		return contactDao.delete(map);
	}

}
