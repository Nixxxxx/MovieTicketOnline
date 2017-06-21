package com.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.CinemaDao;
import com.entity.Cinema;
import com.entity.PageBean;

@Service
public class OrderService {

	@Resource
	private CinemaDao cinemaDao;
	
	public CinemaDao getCinemaDao() {
		return cinemaDao;
	}

	public void setCinemaDao(CinemaDao cinemaDao) {
		this.cinemaDao = cinemaDao;
	}

	public boolean save(Cinema cinema){
		return cinemaDao.save(cinema);
	}

	public boolean update(Cinema cinema) {
		return cinemaDao.update(cinema);
	}
	

	public boolean delete(int cinemaId) {
		return cinemaDao.delete(cinemaId);
	}
	
	public List<Cinema> findAll(){
		return cinemaDao.findAll();
	}
	
	public Cinema findByCinemaId(int cinemaId){
		return cinemaDao.findByCinemaId(cinemaId);
	}

	public List<Cinema> findPage(PageBean pageBean, Cinema s_cinema) {
		return cinemaDao.findPage(pageBean, s_cinema);
	}
}
