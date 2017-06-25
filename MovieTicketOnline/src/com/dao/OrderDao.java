package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.entity.Order;
import com.entity.PageBean;

@Repository
public class OrderDao {

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
	
	public boolean insert(Order order){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.save(order);
		tx.commit();
		session.close();
		return true;
	}
	
	public boolean delete(int orderId){
		Order order = findByOrderId(orderId);
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.delete(order);
		tx.commit();
		session.close();
		return true;
	}
	
	public boolean update(Order order){
		Session session=getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx=session.beginTransaction();
		session.merge(order);
		tx.commit();
		session.close();
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<Order> findPage(PageBean pageBean, Order s_order){
		StringBuffer sb = new StringBuffer("from Order");
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
        List<Order> orderList = q.list();
        tx.commit();
        session.close();
		return orderList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Order> findAll(){
		String queryString="from Order";
		return (List<Order>) this.hibernateTemplate.find(queryString);
	}
	
	public Order findByOrderId(int orderId){
		return (Order) this.hibernateTemplate.get(Order.class, orderId);
	}


}