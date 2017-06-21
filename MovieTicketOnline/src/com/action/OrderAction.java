package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.service.OrderService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(name="/order")
public class OrderAction {

	@Autowired
	private OrderService orderService;

	private String msg;
	private boolean success;
	private JSONObject resultJson=new JSONObject();
	
	public OrderService getOrderService() {
		return orderService;
	}

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}
	
	@RequestMapping(name="/list")
	public ModelAndView showList(HttpServletResponse response){
		ModelAndView mav = new ModelAndView("/order/list");
		
		return mav;
	}
	
	@RequestMapping(name="/add")
	public void save(HttpServletRequest request){
		
	}
}
