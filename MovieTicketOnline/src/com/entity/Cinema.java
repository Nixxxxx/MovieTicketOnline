package com.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="cinema")
public class Cinema {

	private int cinemaId;
	private String number;
	private String name;
	private String address;
	private Set<Schedule> schedules = new HashSet<Schedule>();
	
	public Cinema() {
		super();
	}

	public Cinema(String number, String name, String address) {
		this.number = number;
		this.name = name;
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

	@Column(name="name",nullable=false,length=40)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Column(name="address",nullable=false,length=100)
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	@OneToMany
	@Cascade(value={CascadeType.SAVE_UPDATE})
	@JoinColumn(name="cinemaId")
	@Transient
	public Set<Schedule> getSchedules() {
		return schedules;
	}

	public void setSchedules(Set<Schedule> schedules) {
		this.schedules = schedules;
	}
	
	
}
