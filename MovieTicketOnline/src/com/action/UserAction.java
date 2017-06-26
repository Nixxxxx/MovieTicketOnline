package com.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.entity.Movie;
import com.entity.Order;
import com.entity.PageBean;
import com.entity.Schedule;
import com.entity.User;
import com.service.CinemaService;
import com.service.MovieService;
import com.service.OrderService;
import com.service.ScheduleService;
import com.service.UserService;
import com.util.MD5Util;
import com.util.PageUtil;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/user")
public class UserAction {


	@Autowired
	private UserService userService;
	@Autowired
	private CinemaService cinemaService;
	@Autowired
	private MovieService movieService;
	@Autowired
	private ScheduleService scheduleService;
	@Autowired
	private OrderService orderService;
	
	private String msg;
	private boolean success;
	private JSONObject resultJson = new JSONObject();
	
	
	@RequestMapping(value = "/signIn")
	public void signIn(String adminName,String password,String captcha,String checkbox,HttpServletRequest request,HttpServletResponse response){
		List<User> users = userService.findAll();
		String sRand = (String)request.getSession().getAttribute("sRand");
		int flag = 0;
		String result = "";
		JSONObject resultJson = new JSONObject();
		if(captcha.equalsIgnoreCase(sRand)){
			flag = 1;
			for(User user:users){
				if(user.getUserName().equals(adminName)&&MD5Util.getMD5Code(password).equals(user.getPassword())){
					user = userService.findByUserId(user.getUserId());
					request.getSession().setAttribute("user", user);
					if("true".equals(checkbox)){
						Cookie cookie = new Cookie(user.getUserName(),user.getPassword());
						cookie.setMaxAge(1*60*60*24*7);
					}
					flag = 2;break;
				}
			}
		}
		if(flag == 1) 
			result = "用户名或密码错误";
		if(flag == 0)
			result = "验证码错误";
		resultJson.put("result",result);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value = "/index")
	public ModelAndView signIned(){
		ModelAndView mav = new ModelAndView("/index");
		List<Movie> movieList = movieService.find("1");
		Map<Integer, Integer> map = new HashMap<Integer,Integer>();
		List<Schedule> schedules = scheduleService.findAll();
		for (Schedule schedule:schedules){
			if(map.get(schedule.getMovie().getMovieId()) == null){
				map.put(schedule.getMovie().getMovieId(), 0);
			}else{
			}
		}
		mav.addObject("movieList", movieList);
		return mav;
	}
	
	@RequestMapping(value = "/signOut")
	public ModelAndView signOut(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("user");
		if(user != null){
			request.getSession().removeAttribute("user");
		}
		return new ModelAndView("../../signIn");
	}
	
	public boolean checkUserName(String userName, int userId){
		List<User> users = userService.findAll();
		for(User user:users){
			if(userName.equals(user.getUserName()) && userId != user.getUserId())
				return false;
		}
		return true;
	}
	
	@RequestMapping(value = "/changePassword")
	public void changePassword(HttpServletRequest request,HttpServletResponse response){
		int userId=Integer.parseInt(request.getParameter("userId"));
		String oldPassword = request.getParameter("oldPassword");
		User user=userService.findByUserId(userId);
		if(user.getPassword().equals(MD5Util.getMD5Code(oldPassword))){
			String newPassword = request.getParameter("newPassword");
			success=userService.changePassword(userId,MD5Util.getMD5Code(newPassword));
			if(success)
				msg = "修改密码成功";
			else msg = "修改密码失败";
		}else {
			success = false;
			msg = "原密码错误";
		}
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value = "/list")
	public ModelAndView showList(User s_user,HttpServletRequest request){
		ModelAndView mav = new ModelAndView("/user/list");
		String page = request.getParameter("page");
		if(StringUtil.isEmpty(page)){
			page="1";
		}else{
			s_user = (User) request.getSession().getAttribute("s_user");
		}
		PageBean pageBean = new PageBean(Integer.parseInt(page),10);
		List<User> userList = userService.findPage(pageBean, s_user);
		int total = userService.findAll().size();
		if(total>0){
			String pageCode = PageUtil.rootPageTion("user/list",total, pageBean.getPage(),pageBean.getPageSize(),null,null);
			mav.addObject("pageCode", pageCode);
			mav.addObject("userList", userList);
		}
		return mav;
	}
	
	@RequestMapping(value = "/signUp")
	public void insert(String userName, String password, String email, String mobile, String captcha,HttpServletRequest request,HttpServletResponse response){
		String sRand = (String)request.getSession().getAttribute("sRand");
		if(captcha.equalsIgnoreCase(sRand)){
			if(checkUserName(userName, 0)){
				User user = new User(userName,MD5Util.getMD5Code(password),email,mobile);
				success = userService.insert(user);
				if(success)
					msg = "注册成功";
				else msg = "注册失败";
			}else {
				success = false;
				msg = "用户名已存在";
			}
		}else{
			msg = "验证码错误";
			success = false;
		}
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value = "/del")
	public void delete(HttpServletRequest request,HttpServletResponse response){
		int userId = Integer.parseInt(request.getParameter("userId"));
		success = userService.delete(userId);
		if(success)
			msg = "删除成功";
		else msg = "删除失败";
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}

	@RequestMapping(value = "/update")
	public void update(HttpServletRequest request,HttpServletResponse response){
		int userId = Integer.parseInt(request.getParameter("userId"));
		User user = userService.findByUserId(userId);
		if(checkUserName(request.getParameter("userName"), userId)){
			user.setUserName(request.getParameter("userName"));
			user.setEmail(request.getParameter("email"));
			user.setMobile(request.getParameter("mobile"));
			success = userService.update(user);
			if(success)
				msg = "修改成功";
			else msg = "修改失败";
		}else {
			success = false;
			msg = "用户名已存在";
		}
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}

	@RequestMapping(value = "/orderList")
	public void orderList(HttpServletRequest request,HttpServletResponse response){
		int userId = Integer.parseInt(request.getParameter("userId"));
		List<Order> orderList = orderService.find(userId);
	}
}
