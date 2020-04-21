package edu.ysu.entity;

import java.util.Date;
/**
 * 药品信息
 * @author lyj
 *
 */
public class MedicaInfo {

	private int medicaId;
	private String name;
    private MedicaClass medicaClass;
	private double price;
	private float volume;
	private Date pdate;
	private String producer;
	
	
	public MedicaClass getMedicaClass() {
		return medicaClass;
	}
	public void setMedicaClass(MedicaClass medicaClass) {
		this.medicaClass = medicaClass;
	}
	public int getMedicaId() {
		return medicaId;
	}
	public void setMedicaId(int medicaId) {
		this.medicaId = medicaId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public float getVolume() {
		return volume;
	}
	public void setVolume(float volume) {
		this.volume = volume;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	public String getProducer() {
		return producer;
	}
	public void setProducer(String producer) {
		this.producer = producer;
	}
	public MedicaInfo() {
		// TODO Auto-generated constructor stub
	}

}
