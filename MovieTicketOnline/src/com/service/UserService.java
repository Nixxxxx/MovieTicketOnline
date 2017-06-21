package com.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.UserDao;
import com.entity.PageBean;
import com.entity.User;

@Service
public class UserService {

	@Resource
	private UserDao userDao = new UserDao();
	
	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public User signIn(String userName,String password){
		if(userName==""||userName==null||password==""||password==null){
			return null;
		}
		return userDao.signIn(userName, password);
	}
	
	public boolean changePassword(int userId,String password) {
		return userDao.changePassword(userId, password);
	}
	
	public boolean insert(User user){
		return userDao.insert(user);
	}

	public boolean update(User user) {
		return userDao.update(user);
	}

	public boolean delete(int userId) {
		return userDao.delete(userId);
	}
	
	public List<User> findPage(PageBean pageBean,User s_user){
		return userDao.findPage(pageBean, s_user);
	}
	
	public List<User> findAll(){
		return userDao.findAll();
	}
	
	public User findByUserId(int userId){
		return userDao.findByUserId(userId);
	}

}
