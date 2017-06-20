package com.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.AdminDao;
import com.entity.Admin;
import com.entity.PageBean;

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
		if(adminName==""||adminName==null||password==""||password==null){
			return null;
		}
		return adminDao.signIn(adminName, password);
	}
	
	public boolean save(Admin admin){
		return adminDao.save(admin);
	}

	public boolean update(Admin admin) {
		return adminDao.update(admin);
	}
	
	public boolean changePassword(int adminId,String password) {
		return adminDao.changePassword(adminId, password);
	}

	public boolean delete(int adminId) {
		return adminDao.delete(adminId);
	}
	
	public List<Admin> find(PageBean pageBean,Admin s_admin){
		return adminDao.find(pageBean, s_admin);
	}
	
	public List<Admin> findAll(){
		return adminDao.findAll();
	}
	
	public Admin findByAdminId(int adminId){
		return adminDao.findByAdminId(adminId);
	}
}
