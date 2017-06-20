package com.action;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.entity.Admin;
import com.service.AdminService;
import com.util.MD5Util;
import com.util.ResponseUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/admin")
public class AdminAction {

	@Autowired
	private AdminService adminService;
	
	private String msg;
	private boolean success;
	private JSONObject resultJson=new JSONObject();
	

	public AdminService getAdminService() {
		return adminService;
	}

	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}
	
	@RequestMapping(value="/signIn")
	public void login(String userName,String password,String captcha,String checkbox,HttpServletRequest request,HttpServletResponse response){
		List<Admin> admins=adminService.findAll();
		String sRand=(String)request.getSession().getAttribute("sRand");
		int flag=0;
		String result="";
		JSONObject resultJson=new JSONObject();
		if(captcha.equalsIgnoreCase(sRand)){
			flag=1;
			for(Admin admin:admins){
				if(admin.getAdminName().equals(userName)&&MD5Util.getMD5Code(password).equals(admin.getPassword())){
					admin=adminService.findByAdminId(admin.getAdminId());
					request.getSession().setAttribute("admin", admin);
					if("true".equals(checkbox)){
						Cookie cookie=new Cookie(admin.getAdminName(),admin.getPassword());
						cookie.setMaxAge(1*60*60*24*7);
					}
					flag=2;break;
				}
			}
		}
		if(flag==1) 
			result="用户名或密码错误";
		if(flag==0)
			result="验证码错误";
		resultJson.put("result",result);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value="/index")
	public ModelAndView signIned(){
		return new ModelAndView("index");
	}
}
