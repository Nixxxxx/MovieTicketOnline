package com.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="cinema")
public class Cinema {

	private int cinemaId;
	private String number;
	private String cinemaName;
	private String address;
	
	public Cinema() {
		super();
	}

	public Cinema(String number, String cinemaName, String address) {
		this.number = number;
		this.cinemaName = cinemaName;
		this.address = address;
	}
	
	@Id
	@Column(name="cinemaId",nullable=false,unique=true)
	@GenericGenerator(name="generator",strategy="native")
	@GeneratedValue(generator="generator")
	public int getCinemaId() {
		return cinemaId;
	}
	public void setCinemaId(int cinemaId) {
		this.cinemaId = cinemaId;
	}
	
	@Column(name="number",nullable=false,length=40)
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	@Column(name="cinemaName",nullable=false,length=40)
	public String getCinemaName() {
		return cinemaName;
	}
	public void setCinemaName(String cinemaName) {
		this.cinemaName = cinemaName;
	}
	
	@Column(name="address",nullable=false,length=100)
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
