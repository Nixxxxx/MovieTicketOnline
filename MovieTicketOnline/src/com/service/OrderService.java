package com.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.OrderDao;
import com.entity.Order;
import com.entity.PageBean;

@Service
public class OrderService {

	@Resource
	private OrderDao orderDao;
	
	public OrderDao getOrderDao() {
		return orderDao;
	}

	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	public boolean insert(Order order){
		return orderDao.insert(order);
	}

	public boolean delete(int orderId) {
		return orderDao.delete(orderId);
	}
	
	public boolean update(Order order) {
		return orderDao.update(order);
	}
	
	public List<Order> findPage(PageBean pageBean, Order s_order) {
		return orderDao.findPage(pageBean, s_order);
	}
	
	public List<Order> findAll(){
		return orderDao.findAll();
	}
	
	public Order findByOrderId(int orderId){
		return orderDao.findByOrderId(orderId);
	}

}
