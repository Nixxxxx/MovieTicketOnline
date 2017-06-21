package com.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.entity.Cinema;
import com.entity.PageBean;
import com.service.CinemaService;
import com.util.PageUtil;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(name="/cinema")
public class CinemaAction {

	@Autowired
	private CinemaService cinemaService;

	private String msg;
	private boolean success;
	private JSONObject resultJson=new JSONObject();
	
	public CinemaService getCinemaService() {
		return cinemaService;
	}

	public void setCinemaService(CinemaService cinemaService) {
		this.cinemaService = cinemaService;
	}

	@RequestMapping(name="/insert")
	public ModelAndView add(){
		return new ModelAndView("/cinema/add");
	}
	
	@RequestMapping(value="/list")
	public ModelAndView showList(Cinema s_cinema,HttpServletRequest request){
		ModelAndView mav=new ModelAndView("/cinema/manage");
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
	
	
	@RequestMapping(value="/insert")
	public void insert(HttpServletRequest request,HttpServletResponse response){
		String number = request.getParameter("number");
		String cinemaName = request.getParameter("cinemaName");
		String address = request.getParameter("address");
		Cinema cinema = new Cinema(number, cinemaName, address);
		cinemaService.save(cinema);
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value="/update")
	public void update(HttpServletRequest request,HttpServletResponse response){
		int id = Integer.parseInt(request.getParameter("cinemaId"));
		String number = request.getParameter("number");
		if(checkNumber(number)){
			String cinemaName = request.getParameter("cinemaName");
			String address = request.getParameter("address");
			Cinema cinema = new Cinema(number,cinemaName,address);
			success = cinemaService.update(cinema);
			if(success)
				msg = "更新成功";
			else msg = "更新失败";
		}else{
			success = false;
			msg="编号已存在";
		}
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value="/del")
	public void delete(HttpServletRequest request,HttpServletResponse response){
		int id=Integer.parseInt(request.getParameter("id"));
		success=cinemaService.delete(id);
		if(success)
			msg="删除成功";
		else msg="删除失败";
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	public boolean checkNumber(String number){
		List<Cinema> cinemas = cinemaService.findAll();
		for(Cinema cinema:cinemas){
			if(number.equals(cinema.getNumber()))
				return false;
		}
		return true;
	}
	
	
}
