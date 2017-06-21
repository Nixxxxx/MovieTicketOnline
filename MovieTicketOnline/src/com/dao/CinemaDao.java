package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.entity.Cinema;
import com.entity.PageBean;

@Repository
public class CinemaDao {

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
	
	public boolean save(Cinema cinema){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.save(cinema);
		tx.commit();
		session.close();
		return true;
	}
	
	public boolean update(Cinema cinema){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.merge(cinema);
		tx.commit();
		session.close();
		return true;
	}
	
	public boolean delete(int cinemaId){
		Cinema cinema = findByCinemaId(cinemaId);
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.delete(cinema);
		tx.commit();
		session.close();
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<Cinema> findAll(){
		String queryString="from Cinema";
		return (List<Cinema>) this.hibernateTemplate.find(queryString);
	}
	
	public Cinema findByCinemaId(int cinemaId){
		return (Cinema) this.hibernateTemplate.get(Cinema.class, cinemaId);
	}

	public List<Cinema> findPage(PageBean pageBean, Cinema s_admin) {
		String queryString = "";
		
		return null;
	}
}
