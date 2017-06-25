package com.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.entity.PageBean;
import com.entity.Schedule;
import com.service.CinemaService;
import com.service.MovieService;
import com.service.ScheduleService;
import com.util.PageUtil;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/schedule")
public class ScheduleAction {

	@Autowired
	private ScheduleService scheduleService;
	@Autowired
	private MovieService movieService;
	@Autowired
	private CinemaService cinemaService;

	private String msg;
	private boolean success;
	private JSONObject resultJson=new JSONObject();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
	
	public ScheduleService getScheduleService() {
		return scheduleService;
	}

	public void setScheduleService(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}
	
	
	
	public MovieService getMovieService() {
		return movieService;
	}

	public void setMovieService(MovieService movieService) {
		this.movieService = movieService;
	}

	public CinemaService getCinemaService() {
		return cinemaService;
	}

	public void setCinemaService(CinemaService cinemaService) {
		this.cinemaService = cinemaService;
	}

	@RequestMapping(value="/add")
	public ModelAndView add(){
		ModelAndView mav = new ModelAndView("/schedule/add");
		mav.addObject("cinemas", cinemaService.findAll());
		mav.addObject("movies", movieService.findAll());
		return mav;
	}
	
	@RequestMapping(value="/list")
	public ModelAndView showList(Schedule s_schedule,HttpServletRequest request){
		ModelAndView mav=new ModelAndView("/schedule/list");
		String page=request.getParameter("page");
		if(StringUtil.isEmpty(page)){
			page="1";
		}else{
			s_schedule=(Schedule) request.getSession().getAttribute("s_schedule");
		}
		PageBean pageBean=new PageBean(Integer.parseInt(page),10);
		List<Schedule> scheduleList=scheduleService.findPage(pageBean, s_schedule);
		int total=scheduleService.findAll().size();
		if(total>0){
			String pageCode=PageUtil.rootPageTion("schedule/list",total, pageBean.getPage(),pageBean.getPageSize(),null,null);
			mav.addObject("pageCode", pageCode);
			mav.addObject("scheduleList", scheduleList);
		}
		return mav;
	}
	
	@RequestMapping(value = "/insert")
	public void insert(HttpServletRequest request,HttpServletResponse response) throws ParseException{
		int cinemaId = Integer.parseInt(request.getParameter("cinemaId"));
		int movieId = Integer.parseInt(request.getParameter("movieId"));
		String date = request.getParameter("date");
		String hour = request.getParameter("hour");
		String minute = request.getParameter("minute");
		Date startTime = sdf.parse(date+" "+hour+":"+minute);
		int seat =Integer.parseInt(request.getParameter("seat")); 
		Schedule schedule = new Schedule(cinemaService.findByCinemaId(cinemaId), movieService.findByMovieId(movieId), startTime, seat);
		success = scheduleService.insert(schedule);
		if(success)
			msg = "更新成功";
		else msg = "更新失败";
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value = "/del")
	public void delete(HttpServletRequest request,HttpServletResponse response){
		int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
		success = scheduleService.delete(scheduleId);
		if(success)
			msg = "删除成功";
		else msg ="删除失败";
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value = "/update")
	public void update(HttpServletRequest request,HttpServletResponse response) throws ParseException{
		int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
		Schedule schedule = scheduleService.findByscheduleId(scheduleId);
		String date = request.getParameter("date");
		String hour = request.getParameter("hour");
		String minute = request.getParameter("minute");
		schedule.setStartTime(sdf.parse(date+" "+hour+":"+minute));
		schedule.setSeat(Integer.parseInt(request.getParameter("seat")));
		success = scheduleService.update(schedule);
		if(success)
			msg = "更新成功";
		else msg = "更新失败";
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
}
