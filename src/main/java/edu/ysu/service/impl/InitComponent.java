package edu.ysu.service.impl;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import edu.ysu.entity.Manager;
import edu.ysu.service.ManagerService;


@Component
public class InitComponent implements ServletContextListener,ApplicationContextAware{

	private static ApplicationContext applicationContext;
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.applicationContext=applicationContext;
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {

		ServletContext application=sce.getServletContext();
		ManagerService managerService=(ManagerService)applicationContext.getBean("managerService");
		Manager manager=managerService.getByUserName("lyj");
		application.setAttribute("manager",manager);
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		
	}

}
