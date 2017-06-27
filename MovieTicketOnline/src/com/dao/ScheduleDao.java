package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.entity.PageBean;
import com.entity.Schedule;

@Repository
public class ScheduleDao {


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
	
	public boolean insert(Schedule schedule){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.save(schedule);
		tx.commit();
		session.close();
		return true;
	}
	
	public boolean delete(int scheduleId){
		Schedule schedule = findByScheduleId(scheduleId);
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.delete(schedule);
		tx.commit();
		session.close();
		return true;
	}
	
	public boolean update(Schedule schedule){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.merge(schedule);
		tx.commit();
		session.close();
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<Schedule> findPage(PageBean pageBean, Schedule s_schedule){
		StringBuffer sb=new StringBuffer("from Schedule");
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
        List<Schedule> scheduleList=q.list();
        tx.commit();
        session.close();
		return scheduleList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Schedule> findAll(){
		return (List<Schedule>) this.hibernateTemplate.find("from Schedule");
	}
	
	public Schedule findByScheduleId(int scheduleId){
		return (Schedule) this.hibernateTemplate.get(Schedule.class, scheduleId);
	}
	
	@SuppressWarnings("unchecked")
	public List<Schedule> find(int movieId) {
		return (List<Schedule>) this.hibernateTemplate.find("from Schedule s where s.movieId=?", movieId);
	}
}
