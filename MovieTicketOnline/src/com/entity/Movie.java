package com.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="movie")
public class Movie {

	int movieId;
	String movieName;
	int status;
	String introduce;
	Date time;
	
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
	
	@Column(name="movieName",nullable=false,length=40)
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	
	@Column(name="status",nullable=false,length=1)
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	@Column(name="introduce",nullable=false,length=40)
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	
	@Column(name="time",nullable=false,length=40)
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
}
