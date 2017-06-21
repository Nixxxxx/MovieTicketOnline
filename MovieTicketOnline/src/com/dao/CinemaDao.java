package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
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
	
	public boolean insert(Cinema cinema){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.save(cinema);
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
	
	public boolean update(Cinema cinema){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.merge(cinema);
		tx.commit();
		session.close();
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<Cinema> findPage(PageBean pageBean, Cinema s_cinema){
		StringBuffer sb=new StringBuffer("from Cinema");
//		if(s_admin!=null){
//			if(StringUtil.isNotEmpty(s_admin.getNumber())){
//				sb.append(" and deptName like '%"+s_admin.getName()+"%'");
//			}
//		}
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		Query q = session.createQuery(sb.toString());
		q.setFirstResult(pageBean.getStart());
        q.setMaxResults(pageBean.getPageSize());
        List<Cinema> cinemaList=q.list();
        tx.commit();
        session.close();
		return cinemaList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Cinema> findAll(){
		String queryString="from Cinema";
		return (List<Cinema>) this.hibernateTemplate.find(queryString);
	}
	
	public Cinema findByCinemaId(int cinemaId){
		return (Cinema) this.hibernateTemplate.get(Cinema.class, cinemaId);
	}

}
