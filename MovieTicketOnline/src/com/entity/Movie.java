package com.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="movie")
public class Movie {

	int movieId;
	String movieName;
	String introduce;
}
