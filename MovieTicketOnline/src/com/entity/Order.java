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

	int orderId;
	int userId;
	int movieId;
	int number;
	String address;
	String mobile;
	
	
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
	
	@Column(name="movieId",nullable=false,length=10)
	public int getMovieId() {
		return movieId;
	}
	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}
	
	@Column(name="number",nullable=false,length=2)
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	
	@Column(name="address",nullable=false,length=40)
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	@Column(name="mobile",nullable=false,length=40)
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	
}
