package com.action;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.entity.PageBean;
import com.entity.User;
import com.service.UserService;
import com.util.MD5Util;
import com.util.PageUtil;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/user")
public class UserAction {


	@Autowired
	private UserService userService;
	
	private String msg;
	private boolean success;
	private JSONObject resultJson=new JSONObject();
	
	@RequestMapping(value="/add")
	public ModelAndView add(){
		return new ModelAndView("/user/add");
	}
	
	@RequestMapping(value="/signIn")
	public void signIn(String adminName,String password,String captcha,String checkbox,HttpServletRequest request,HttpServletResponse response){
		List<User> users=userService.findAll();
		String sRand=(String)request.getSession().getAttribute("sRand");
		int flag=0;
		String result="";
		JSONObject resultJson=new JSONObject();
		if(captcha.equalsIgnoreCase(sRand)){
			flag=1;
			for(User user:users){
				if(user.getUserName().equals(adminName)&&MD5Util.getMD5Code(password).equals(user.getPassword())){
					user=userService.findByUserId(user.getUserId());
					request.getSession().setAttribute("user", user);
					if("true".equals(checkbox)){
						Cookie cookie=new Cookie(user.getUserName(),user.getPassword());
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
		return new ModelAndView("/index");
	}
	
	@RequestMapping(value="/signOut")
	public ModelAndView signOut(HttpServletRequest request){
		User user=(User) request.getSession().getAttribute("user");
		if(user!=null){
			request.getSession().removeAttribute("user");
		}
		return new ModelAndView("../../signIn");
	}
	
	public boolean checkUserName(String userName, int userId){
		List<User> users=userService.findAll();
		for(User user:users){
			if(userName.equals(user.getUserName()) || userId != user.getUserId())
				return false;
		}
		return true;
	}
	
	@RequestMapping(value="/changePassword")
	public void changePassword(HttpServletRequest request,HttpServletResponse response){
		int userId=Integer.parseInt(request.getParameter("userId"));
		String oldPassword=request.getParameter("oldPassword");
		User user=userService.findByUserId(userId);
		if(user.getPassword().equals(MD5Util.getMD5Code(oldPassword))){
			String newPassword=request.getParameter("newPassword");
			success=userService.changePassword(userId,MD5Util.getMD5Code(newPassword));
			if(success)
				msg="修改密码成功";
			else msg="修改密码失败";
		}else {
			success=false;
			msg="原密码错误";
		}
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value="/list")
	public ModelAndView showList(User s_user,HttpServletRequest request){
		ModelAndView mav=new ModelAndView("/user/list");
		String page=request.getParameter("page");
		if(StringUtil.isEmpty(page)){
			page="1";
		}else{
			s_user=(User) request.getSession().getAttribute("s_user");
		}
		PageBean pageBean=new PageBean(Integer.parseInt(page),10);
		List<User> userList=userService.findPage(pageBean, s_user);
		int total=userService.findAll().size();
		if(total>0){
			String pageCode=PageUtil.rootPageTion("user/list",total, pageBean.getPage(),pageBean.getPageSize(),null,null);
			mav.addObject("pageCode", pageCode);
			mav.addObject("userList", userList);
		}
		return mav;
	}
	
	@RequestMapping(value="/insert")
	public void insert(HttpServletRequest request,HttpServletResponse response){
		String userName=request.getParameter("userName");
		if(checkUserName(userName, 0)){
			String password=request.getParameter("password");
			String email=request.getParameter("email");
			String mobile=request.getParameter("mobile");
			User user=new User(userName,MD5Util.getMD5Code(password),email,mobile);
			success=userService.insert(user);
			if(success)
				msg="添加成功";
			else msg="添加失败";
		}else {
			success=false;
			msg="用户名已存在";
		}
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value="/del")
	public void delete(HttpServletRequest request,HttpServletResponse response){
		int userId=Integer.parseInt(request.getParameter("userId"));
		success=userService.delete(userId);
		if(success)
			msg="删除成功";
		else msg="删除失败";
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}

	@RequestMapping(value="/update")
	public void update(HttpServletRequest request,HttpServletResponse response){
		int userId=Integer.parseInt(request.getParameter("userId"));
		User user=userService.findByUserId(userId);
		if(checkUserName(request.getParameter("userName"), userId)){
			user.setUserName(request.getParameter("userName"));
			user.setEmail(request.getParameter("email"));
			user.setMobile(request.getParameter("mobile"));
			success=userService.update(user);
			if(success)
				msg="修改成功";
			else msg="修改失败";
		}else {
			success=false;
			msg="用户名已存在";
		}
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}

}
