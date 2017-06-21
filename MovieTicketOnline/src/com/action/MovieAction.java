package com.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.service.MovieService;

@Controller
@RequestMapping(name="/movie")
public class MovieAction {

	@Autowired
	private MovieService movieService = new MovieService();

	public MovieService getMovieService() {
		return movieService;
	}

	public void setMovieService(MovieService movieService) {
		this.movieService = movieService;
	}
	
	@RequestMapping(name = "/list")
	public ModelAndView showList(){
		ModelAndView mav = new ModelAndView("/movie/list");
		return mav;
	}
}
