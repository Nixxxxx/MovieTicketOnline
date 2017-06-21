package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.entity.User;
import com.entity.PageBean;

@Repository
public class UserDao {

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

	public User signIn(String userName,String password){
		User user=null;
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Query query=session.createQuery("from user u where u.userName = ? and u.password =?");
		query.setParameter("userName", userName);
		query.setParameter("password", password);
		@SuppressWarnings("unchecked")
		List<User> lists=query.list();
		if(lists!=null&&lists.size()>0){
			user=lists.get(0);
		}
		session.close();
		return user;
	}
	
	public boolean insert(User user){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.save(user);
		tx.commit();
		session.close();
		return true;
	}
	
	public boolean delete(int userId){
		User user=this.findByUserId(userId);
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tr=session.beginTransaction();
		session.delete(user); 
		tr.commit();
		session.close();
		return true;
	}
	
	public boolean update(User user){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.merge(user);
		tx.commit();
		session.close();
		return true;
	}
	
	public boolean changePassword(int userId,String password){
		User user=this.findByUserId(userId);
		user.setPassword(password);
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.merge(user);
		tx.commit();
		session.close();
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<User> findPage(PageBean pageBean, User s_user){
		StringBuffer sb=new StringBuffer("from User");
//		if(s_user!=null){
//			if(StringUtil.isNotEmpty(s_user.getNumber())){
//				sb.append(" and deptName like '%"+s_user.getName()+"%'");
//			}
//		}
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		Query q = session.createQuery(sb.toString());
		q.setFirstResult(pageBean.getStart());
        q.setMaxResults(pageBean.getPageSize());
        List<User> userList=q.list();
        tx.commit();
        session.close();
		return userList;
	}
	
	@SuppressWarnings("unchecked")
	public List<User> findAll(){
		String queryString="from User";
		return (List<User>) this.hibernateTemplate.find(queryString);
	}
	
	public User findByUserId(int userId){
		return (User) this.hibernateTemplate.get(User.class, userId);
	}

}
