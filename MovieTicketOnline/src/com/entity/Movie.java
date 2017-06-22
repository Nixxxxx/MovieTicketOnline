package com.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="movie")
public class Movie {

	private int movieId;
	private String number;
	private String movieName;
	private String time;
	private String status;
	private String introduce;
	
	public Movie() {
		super();
	}

	public Movie(String number, String movieName, String time, String introduce) {
		this.number = number;
		this.movieName = movieName;
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
	
	@Column(name="movieName",nullable=false,length=40)
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
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
	
}
