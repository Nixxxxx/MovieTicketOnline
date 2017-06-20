package com.service;

import org.springframework.stereotype.Service;

import com.dao.AdminDao;

@Service
public class AdminService {

	private AdminDao adminDao;

	public AdminDao getAdminDao() {
		return adminDao;
	}

	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	
}
