package com.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="admin")
public class Admin {

	int adminId;
	String adminName;
	String password;
	
	@Id
	@Column(name="adminId",nullable=false,unique=true)
	@GenericGenerator(name="generator",strategy="native")
	@GeneratedValue(generator="generator")
	public int getAdminId() {
		return adminId;
	}
	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}
	
	@Column(name="adminName",nullable=false,length=40)
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	
	@Column(name="password",nullable=false,length=64)
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
