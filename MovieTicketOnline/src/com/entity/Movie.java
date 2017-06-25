package com.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="movie")
public class Movie {

	private int movieId;
	private String number;
	private String name;
	private String time;
	private String status = "0";
	private String introduce;
	private Set<Schedule> schedules = new HashSet<Schedule>();
	
	public Movie() {
		super();
	}

	public Movie(String number, String name, String time, String introduce) {
		this.number = number;
		this.name = name;
		this.time = time;
		this.introduce = introduce;
	}
	
	@Id
	@Column(name="movieId",nullable=false,unique=true)
	@GenericGenerator(name="generator",strategy="native")
	@GeneratedValue(generator="generator")
	public int getMovieId() {
		return movieId;
	}
	public void setMovieId(int movieId) {
		this.movieId = movieId;
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
	
	@Column(name="time",nullable=false,length=4)
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	@Column(name="status",nullable=false,length=1)
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Column(name="introduce",nullable=false,length=100)
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	@OneToMany(fetch=FetchType.LAZY,cascade = CascadeType.MERGE)
	@JoinColumn(name = "movieId")
	@Transient
	public Set<Schedule> getSchedules() {
		return schedules;
	}

	public void setSchedules(Set<Schedule> schedule) {
		this.schedules = schedule;
	}
	
	
}
