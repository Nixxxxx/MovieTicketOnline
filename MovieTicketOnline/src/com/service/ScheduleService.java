package com.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.ScheduleDao;
import com.entity.PageBean;
import com.entity.Schedule;

@Service
public class ScheduleService {

	@Resource
	private ScheduleDao scheduleDao;
	
	public ScheduleDao getScheduleDao() {
		return scheduleDao;
	}

	public void setScheduleDao(ScheduleDao scheduleDao) {
		this.scheduleDao = scheduleDao;
	}

	public boolean insert(Schedule schedule){
		return scheduleDao.insert(schedule);
	}

	public boolean delete(int scheduleId) {
		return scheduleDao.delete(scheduleId);
	}

	public boolean update(Schedule schedule) {
		return scheduleDao.update(schedule);
	}

	public List<Schedule> findPage(PageBean pageBean, Schedule s_schedule) {
		return scheduleDao.findPage(pageBean, s_schedule);
	}
	
	public List<Schedule> findAll(){
		return scheduleDao.findAll();
	}
	
	public Schedule findByScheduleId(int scheduleId){
		return scheduleDao.findByScheduleId(scheduleId);
	}
}
