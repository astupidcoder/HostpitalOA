package edu.ysu.entity;

/**
 * 联系人实体类
 * @author lyj
 *
 */
public class Contact {

	private Integer id; //id
	private String userNo1;  //自己的第一用户编号
	private Doctor doctor;   //联系人实体
	private String qq;
	private String email;
	private String tel;
	private String userName;  //自己添加的联系人的姓名，在doctor数据库中不存在的信息
	private String remark; //备注信息
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUserNo1() {
		return userNo1;
	}
	public void setUserNo1(String userNo1) {
		this.userNo1 = userNo1;
	}
	public Doctor getDoctor() {
		return doctor;
	}
	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}
	
	
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Contact(Integer id, String userNo1, Doctor doctor) {
		super();
		this.id = id;
		this.userNo1 = userNo1;
		this.doctor = doctor;
	}
	public Contact() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
}
