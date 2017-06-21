package com.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.MovieDao;
import com.entity.Movie;
import com.entity.PageBean;

@Service
public class MovieService {

	@Resource
	private MovieDao movieDao;
	
	public MovieDao getMovieDao() {
		return movieDao;
	}

	public void setMovieDao(MovieDao movieDao) {
		this.movieDao = movieDao;
	}

	public boolean insert(Movie movie){
		return movieDao.save(movie);
	}

	public boolean update(Movie movie) {
		return movieDao.update(movie);
	}
	

	public boolean delete(int movieId) {
		return movieDao.delete(movieId);
	}
	
	public List<Movie> findAll(){
		return movieDao.findAll();
	}
	
	public Movie findByMovieId(int movieId){
		return movieDao.findByMovieId(movieId);
	}

	public List<Movie> findPage(PageBean pageBean, Movie s_movie) {
		return movieDao.findPage(pageBean, s_movie);
	}
}
