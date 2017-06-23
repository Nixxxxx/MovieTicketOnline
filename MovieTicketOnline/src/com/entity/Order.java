package com.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="order")
public class Order {

	private int orderId;
	private int userId;
	private int scheduleId;
	private int amount;
	private String address;
	private String mobile;
	private String status;
	private String extra;
	
	public Order() {
		super();
	}

	public Order(int userId, int scheduleId, int amount, String address, String mobile, String status) {
		super();
		this.userId = userId;
		this.scheduleId = scheduleId;
		this.amount = amount;
		this.address = address;
		this.mobile = mobile;
		this.status = status;
	}


	@Id
	@Column(name="orderId",nullable=false,unique=true)
	@GenericGenerator(name="generator",strategy="native")
	@GeneratedValue(generator="generator")
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	
	@Column(name="userId",nullable=false,length=10)
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	@Column(name="scheduleId",nullable=false,length=10)
	public int getScheduleId() {
		return scheduleId;
	}

	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
	}

	@Column(name="amount",nullable=false,length=3)
	public int getAmount() {
		return amount;
	}
	public void setAmount(int number) {
		this.amount = number;
	}
	
	@Column(name="address",nullable=false,length=40)
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	@Column(name="mobile",nullable=false,length=20)
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@Column(name="status",nullable=false,length=1)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name="extra",nullable=false,length=100)
	public String getExtra() {
		return extra;
	}

	public void setExtra(String extra) {
		this.extra = extra;
	}
	
}
