package com.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.entity.Admin;
import com.entity.Cinema;
import com.entity.PageBean;
import com.service.CinemaService;
import com.util.MD5Util;
import com.util.PageUtil;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(name="/cinema")
public class CinemaAction {

	@Autowired
	private CinemaService cinemaService;

	String msg;
	String success;
	JSONObject resultJson;
	
	public CinemaService getCinemaService() {
		return cinemaService;
	}

	public void setCinemaService(CinemaService cinemaService) {
		this.cinemaService = cinemaService;
	}

	@RequestMapping(value="/list")
	public ModelAndView showList(Cinema s_cinema,HttpServletRequest request){
		ModelAndView mav=new ModelAndView("cinema/manage");
		String page=request.getParameter("page");
		if(StringUtil.isEmpty(page)){
			page="1";
		}else{
			s_cinema=(Cinema) request.getSession().getAttribute("s_cinema");
		}
		PageBean pageBean=new PageBean(Integer.parseInt(page),10);
		List<Cinema> cinemaList=cinemaService.findPage(pageBean, s_cinema);
		int total=cinemaService.findAll().size();
		String pageCode=PageUtil.rootPageTion("cinema/list",total, pageBean.getPage(),pageBean.getPageSize(),null,null);
		mav.addObject("pageCode", pageCode);
		mav.addObject("cinemaList", cinemaList);
		return mav;
	}
	
	@RequestMapping(value="/save")
	public void insert(HttpServletRequest request,HttpServletResponse response){
		String cinemaName = request.getParameter("cinemaName");
		String address = request.getParameter("address");
		Cinema cinema = new Cinema(cinemaName,address);
		cinemaService.save(cinema);
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
}
