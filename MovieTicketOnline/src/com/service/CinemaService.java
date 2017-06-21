package com.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.CinemaDao;
import com.entity.Cinema;
import com.entity.PageBean;

@Service
public class CinemaService {

	@Resource
	private CinemaDao cinemaDao;
	
	public CinemaDao getCinemaDao() {
		return cinemaDao;
	}

	public void setCinemaDao(CinemaDao cinemaDao) {
		this.cinemaDao = cinemaDao;
	}

	public boolean insert(Cinema cinema){
		return cinemaDao.insert(cinema);
	}

	public boolean delete(int cinemaId) {
		return cinemaDao.delete(cinemaId);
	}

	public boolean update(Cinema cinema) {
		return cinemaDao.update(cinema);
	}

	public List<Cinema> findPage(PageBean pageBean, Cinema s_cinema) {
		return cinemaDao.findPage(pageBean, s_cinema);
	}
	
	public List<Cinema> findAll(){
		return cinemaDao.findAll();
	}
	
	public Cinema findByCinemaId(int cinemaId){
		return cinemaDao.findByCinemaId(cinemaId);
	}
	
}
