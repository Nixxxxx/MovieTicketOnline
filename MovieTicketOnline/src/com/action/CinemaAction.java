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
@RequestMapping(value="/cinema")
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

	@RequestMapping(value="/add")
	public ModelAndView add(){
		return new ModelAndView("/cinema/add");
	}
	
	@RequestMapping(value="/list")
	public ModelAndView showList(Cinema s_cinema,HttpServletRequest request){
		ModelAndView mav=new ModelAndView("/cinema/list");
		String page=request.getParameter("page");
		if(StringUtil.isEmpty(page)){
			page="1";
		}else{
			s_cinema=(Cinema) request.getSession().getAttribute("s_cinema");
		}
		PageBean pageBean=new PageBean(Integer.parseInt(page),10);
		List<Cinema> cinemaList=cinemaService.findPage(pageBean, s_cinema);
		int total=cinemaService.findAll().size();
		if(total>0){
			String pageCode=PageUtil.rootPageTion("cinema/list",total, pageBean.getPage(),pageBean.getPageSize(),null,null);
			mav.addObject("pageCode", pageCode);
			mav.addObject("cinemaList", cinemaList);
		}
		return mav;
	}
	
	public boolean checkNumber(String number, int cinemaId){
		List<Cinema> cinemas = cinemaService.findAll();
		for(Cinema cinema:cinemas){
			if(number.equals(cinema.getNumber()) || cinemaId != cinema.getCinemaId())
				return false;
		}
		return true;
	}

	@RequestMapping(value="/insert")
	public void insert(HttpServletRequest request,HttpServletResponse response){
		String number = request.getParameter("number");
		if(checkNumber(number, 0)){
			String name = request.getParameter("name");
			String address = request.getParameter("address");
			Cinema cinema = new Cinema(number, name, address);
			success = cinemaService.insert(cinema);
			if(success)
				msg = "更新成功";
			else msg = "更新失败";
		}else{
			msg = "编号已存在";
			success = false;
		}
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value="/del")
	public void delete(HttpServletRequest request,HttpServletResponse response){
		int cinemaId=Integer.parseInt(request.getParameter("cinemaId"));
		success=cinemaService.delete(cinemaId);
		if(success)
			msg="删除成功";
		else msg="删除失败";
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value="/update")
	public void update(HttpServletRequest request,HttpServletResponse response){
		int cinemaId = Integer.parseInt(request.getParameter("cinemaId"));
		String number = request.getParameter("number");
		if(checkNumber(number, cinemaId)){
			Cinema cinema = cinemaService.findByCinemaId(cinemaId);
			cinema.setNumber(number);
			cinema.setName(request.getParameter("name"));
			cinema.setAddress(request.getParameter("address"));
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
	
}
