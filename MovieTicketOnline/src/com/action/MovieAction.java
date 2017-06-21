package com.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.entity.Movie;
import com.entity.PageBean;
import com.service.MovieService;
import com.util.PageUtil;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(name="/movie")
public class MovieAction {

	@Autowired
	private MovieService movieService = new MovieService();

	private String msg;
	private boolean success;
	private JSONObject resultJson=new JSONObject();
	
	public MovieService getMovieService() {
		return movieService;
	}

	public void setMovieService(MovieService movieService) {
		this.movieService = movieService;
	}
	
	@RequestMapping(value="/list")
	public ModelAndView showList(Movie s_movie,HttpServletRequest request){
		ModelAndView mav=new ModelAndView("/movie/manage");
		String page=request.getParameter("page");
		if(StringUtil.isEmpty(page)){
			page="1";
		}else{
			s_movie=(Movie) request.getSession().getAttribute("s_movie");
		}
		PageBean pageBean=new PageBean(Integer.parseInt(page),10);
		List<Movie> movieList=movieService.findPage(pageBean, s_movie);
		int total=movieService.findAll().size();
		String pageCode=PageUtil.rootPageTion("movie/list",total, pageBean.getPage(),pageBean.getPageSize(),null,null);
		mav.addObject("pageCode", pageCode);
		mav.addObject("movieList", movieList);
		return mav;
	}
	
	
	@RequestMapping(value="/insert")
	public void insert(HttpServletRequest request,HttpServletResponse response){
		String number = request.getParameter("number");
		String movieName = request.getParameter("movieName");
		String time = request.getParameter("time");
		String status = request.getParameter("status");
		String introduce = request.getParameter("introduce");
		Movie movie = new Movie(number, movieName, time, status, introduce);
		movieService.insert(movie);
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	@RequestMapping(value="/update")
	public void update(HttpServletRequest request,HttpServletResponse response){
		int movieId = Integer.parseInt(request.getParameter("movieId"));
		String number = request.getParameter("number");
		if(checkNumber(number)){
			Movie movie = movieService.findByMovieId(movieId);
			movie.setNumber(number);
			movie.setMovieName(request.getParameter("movieName"));
			movie.setTime(request.getParameter("time"));
			movie.setStatus(request.getParameter("status"));
			movie.setIntroduce(request.getParameter("introduce"));
			success = movieService.update(movie);
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
		success=movieService.delete(id);
		if(success)
			msg="删除成功";
		else msg="删除失败";
		resultJson.put("msg",msg);
		resultJson.put("success", success);
		ResponseUtil.writeJson(response,resultJson);
	}
	
	public boolean checkNumber(String number){
		List<Movie> movies = movieService.findAll();
		for(Movie movie:movies){
			if(number.equals(movie.getNumber()))
				return false;
		}
		return true;
	}
	
}
