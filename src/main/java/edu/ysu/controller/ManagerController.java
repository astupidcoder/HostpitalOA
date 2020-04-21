package edu.ysu.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.ysu.entity.Manager;
import edu.ysu.service.ManagerService;
import edu.ysu.util.CryptographyUtil;

/**
 * 管理员controller
 * @author lyj
 *
 */
@Controller
@RequestMapping("/manager")
public class ManagerController {

	@Resource
	private ManagerService managerService;
	/**
	 * 管理员登录
	 * @param manager
	 * @param request
	 * @return
	 */
	@RequestMapping("/login")
	public String login(Manager manager,HttpServletRequest request) {
		Subject subject=SecurityUtils.getSubject();
		UsernamePasswordToken token=new UsernamePasswordToken(manager.getUserName(), CryptographyUtil.md5(manager.getPassword(), "hosptial"));
		System.out.println("登录："+CryptographyUtil.md5(manager.getPassword(), "hosptial"));
		try{
			subject.login(token); // 登录验证		
			return "redirect:/admin/main.jsp";
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("manager", manager);
			request.setAttribute("errorInfo", "用户名或者密码错误！");
			return "admin/login";
		}
	}
}
