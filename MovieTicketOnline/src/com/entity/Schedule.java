package com.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="schedule")
public class Schedule {

	private int scheduleId;
	private int cinemaId;
	private int movieId;
	private Date startTime;
	private int seat;
	private int reservation;
	
	public Schedule(int cinemaId, int movieId, Date startTime, int seat){
		this.cinemaId = cinemaId;
		this.movieId = movieId;
		this.startTime = startTime;
		this.seat = seat;
	}
	
	@Id
	@Column(name="scheduleId", nullable=false, unique=true)
	@GenericGenerator(name="generator",strategy="native")
	@GeneratedValue(generator="generator")
	public int getScheduleId() {
		return scheduleId;
	}
	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
	}
	
	@Column(name="cinemaId", nullable = false, length=10)
	public int getCinemaId() {
		return cinemaId;
	}
	public void setCinemaId(int cinemaId) {
		this.cinemaId = cinemaId;
	}
	
	@Column(name="movieId", nullable = false, length=10)
	public int getMovieId() {
		return movieId;
	}
	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}
	
	@Column(name="startTime", nullable = false)
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	@Column(name="seat", nullable = false, length=4)
	public int getSeat() {
		return seat;
	}
	public void setSeat(int seat) {
		this.seat = seat;
	}
	
	@Column(name="reservation", nullable=false, length=4)
	public int getReservation() {
		return reservation;
	}
	public void setReservation(int reservation) {
		this.reservation = reservation;
	}
	
	
}
