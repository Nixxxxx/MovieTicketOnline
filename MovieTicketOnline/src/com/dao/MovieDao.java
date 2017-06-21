package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.entity.Movie;
import com.entity.PageBean;

@Repository
public class MovieDao {


	@Resource
	private HibernateTemplate hibernateTemplate;
	
	@Resource
	private SessionFactory sessionFactory;
	
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public boolean save(Movie movie){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.save(movie);
		tx.commit();
		session.close();
		return true;
	}
	
	public boolean update(Movie movie){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.merge(movie);
		tx.commit();
		session.close();
		return true;
	}
	
	public boolean delete(int movieId){
		Movie movie = findByMovieId(movieId);
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.delete(movie);
		tx.commit();
		session.close();
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<Movie> findAll(){
		String queryString="from Movie";
		return (List<Movie>) this.hibernateTemplate.find(queryString);
	}
	
	public Movie findByMovieId(int movieId){
		return (Movie) this.hibernateTemplate.get(Movie.class, movieId);
	}

	public List<Movie> findPage(PageBean pageBean, Movie s_admin) {
		String queryString = "";
		
		return null;
	}
}
