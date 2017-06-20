package com.dao;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.entity.Cinema;

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
	
	public boolean delete(Cinema cinema){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.delete(cinema);
		tx.commit();
		session.close();
		return true;
	}
}
