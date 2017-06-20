package com.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="user")
public class User {

	int userId;
	String userName;
	String password;
	
	@Id
	@Column(name="userId",nullable=false,unique=true)
	@GenericGenerator(name="generator",strategy="native")
	@GeneratedValue(generator="generator")
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	@Column(name="userName",nullable=false,length=40)
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	@Column(name="password",nullable=false,length=40)
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
