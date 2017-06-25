package com.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="schedule")
public class Schedule {

	private int scheduleId;
	private Cinema cinema;
	private Movie movie;
	private Date startTime;
	private int seat;
	private int reservation;
	
	
	
	public Schedule() {
		super();
	}

	public Schedule(Cinema cinema, Movie movie, Date startTime, int seat){
		this.cinema = cinema;
		this.movie = movie;
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
	
	@ManyToOne
	@JoinColumn(name="cinemaId")
	public Cinema getCinema() {
		return cinema;
	}
	public void setCinema(Cinema cinema) {
		this.cinema = cinema;
	}
	
	@ManyToOne
	@JoinColumn(name="movieId")
	public Movie getMovie() {
		return movie;
	}
	public void setMovie(Movie movie) {
		this.movie = movie;
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
