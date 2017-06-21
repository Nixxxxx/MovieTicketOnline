package com.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.AdminDao;
import com.entity.Admin;
import com.entity.PageBean;
import com.util.StringUtil;

@Service
public class AdminService {

	@Resource
	private AdminDao adminDao;

	
	public AdminDao getAdminDao() {
		return adminDao;
	}

	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	public Admin signIn(String adminName,String password){
		if(StringUtil.isEmpty(adminName) || StringUtil.isEmpty(password)){
			return null;
		}
		return adminDao.signIn(adminName, password);
	}
	
	public boolean insert(Admin admin){
		return adminDao.insert(admin);
	}

	public boolean delete(int adminId) {
		return adminDao.delete(adminId);
	}

	public boolean update(Admin admin) {
		return adminDao.update(admin);
	}
	
	public boolean changePassword(int adminId,String password) {
		return adminDao.changePassword(adminId, password);
	}
	
	public List<Admin> findPage(PageBean pageBean,Admin s_admin){
		return adminDao.findPage(pageBean, s_admin);
	}
	
	public List<Admin> findAll(){
		return adminDao.findAll();
	}
	
	public Admin findByAdminId(int adminId){
		return adminDao.findByAdminId(adminId);
	}
}
