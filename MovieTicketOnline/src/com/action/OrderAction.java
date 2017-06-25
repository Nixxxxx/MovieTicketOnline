package com.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.entity.Order;
import com.entity.PageBean;
import com.service.OrderService;
import com.service.ScheduleService;
import com.service.UserService;
import com.util.PageUtil;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/order")
public class OrderAction {

	@Autowired
	private OrderService orderService;
	@Autowired
	private UserService userService;
	@Autowired
	private ScheduleService scheduleService;

	private String msg;
	private boolean success;
	private JSONObject resultJson = new JSONObject();
	
	@RequestMapping(value = "/add")
	public ModelAndView add(){
		return new ModelAndView("/order/add");
	}
	
	@RequestMapping(value = "/list")
	public ModelAndView showList(Order s_order,HttpServletRequest request){
		ModelAndView mav = new ModelAndView("/order/list");
		String page=request.getParameter("page");
		if(StringUtil.isEmpty(page)){
			page = "1";
		}else{
			s_order = (Order) request.getSession().getAttribute("s_order");
		}
		PageBean pageBean = new PageBean(Integer.parseInt(page),10);
		List<Order> orderList = orderService.findPage(pageBean, s_order);
		int total = orderService.findAll().size();
		if(total>0){
			String pageCode = PageUtil.rootPageTion("order/list",total, pageBean.getPage(),pageBean.getPageSize(),null,null);
			mav.addObject("pageCode", pageCode);
			mav.addObject("orderList", orderList);
		}
		return mav;
	}
	
	@RequestMapping(value = "/insert")
	public void insert(HttpServletRequest request,HttpServletResponse response){
		int userId = Integer.parseInt(request.getParameter("userId"));
		int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
		int amount = Integer.parseInt(request.getParameter("amount"));
		String adress = request.getParameter("adress");
		String mobile = request.getParameter("mobile");
		String extra = request.getParameter("extra");
		Order order = new Order(userService.findByUserId(userId), scheduleService.findByscheduleId(scheduleId), amount, adress, mobile,extra);
		orderService.insert(order);
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value="/del")
	public void delete(HttpServletRequest request,HttpServletResponse response){
		int orderId=Integer.parseInt(request.getParameter("orderId"));
		success = orderService.delete(orderId);
		if(success)
			msg = "删除成功";
		else msg ="删除失败";
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value="/update")
	public void update(HttpServletRequest request,HttpServletResponse response){
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		Order order = orderService.findByOrderId(orderId);
		order.setAmount(Integer.parseInt(request.getParameter("amount")));
		order.setAddress(request.getParameter("address"));
		order.setMobile(request.getParameter("mobile"));
		success = orderService.update(order);
		if(success)
			msg = "更新成功";
		else msg = "更新失败";
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
}
