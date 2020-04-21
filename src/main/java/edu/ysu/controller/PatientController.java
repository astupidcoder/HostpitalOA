package edu.ysu.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import edu.ysu.entity.Appoint;
import edu.ysu.entity.Doctor;
import edu.ysu.entity.Patient;
import edu.ysu.service.AppointService;
import edu.ysu.service.PatientService;

@Controller
@RequestMapping("/patient")
public class PatientController {

	@Resource
	private PatientService patientService;
	@Resource
	private AppointService appointService;
	@RequestMapping("/login")
	public String login(Patient patient,HttpServletRequest request,HttpSession session)throws Exception{
		try{
			Patient pat=patientService.getByUserNo(patient.getUserNo());
			if((pat==null)||!(pat.getPassword().equals(patient.getPassword()))) {
				request.setAttribute("patient", patient);
				request.setAttribute("errorInfo", "用户名或者密码错误!!！");	
				return "patient/login";
			}else {
				Appoint appoint=appointService.getDoctorByUserNo(pat.getUserNo());
				Doctor doctor=appoint.getDoctor();
				session.setAttribute("doctor",doctor);
				session.setAttribute("currentUser", pat);
				request.setAttribute("menuPage", "/patient/menu.jsp");
				return "patient/mainTemp";
			}
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("patient", patient);
			request.setAttribute("errorInfo", "用户名或者密码错误！");
			return "patient/login";
		}
	}
	
	/**
	 * 点击跳转到首页
	 * @return
	 */
	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		request.setAttribute("menuPage", "/patient/menu.jsp");
		return "patient/mainTemp";
	}
	/**
	 * 预约挂号
	 * @param way
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/appoint")
	public ModelAndView appoint(@RequestParam(value="way",required=false)String way)throws Exception{
		ModelAndView mav=new ModelAndView();
		mav.addObject("mainPage", "/patient/appoint.jsp");
		mav.addObject("menuPage", "/patient/menu.jsp");
		mav.addObject("way",way);
		mav.setViewName("/patient/mainTemp");
		return mav;
	}
	
	/**
	 * 病人获取个人信息，姓名，住址等
	 * @param userNo
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/info")
	public ModelAndView info(HttpServletResponse response)throws Exception{
		ModelAndView mav=new ModelAndView();
		mav.addObject("mainPage", "/patient/info.jsp");
		mav.addObject("menuPage", "/patient/menu.jsp");
		mav.setViewName("/patient/mainTemp");
		return mav;
	}
	
	/**
	 * 病人的挂号，药品等信息详情页面
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/details")
	public ModelAndView details(HttpServletResponse response)throws Exception{
		ModelAndView mav=new ModelAndView();
		mav.addObject("mainPage", "/patient/details.jsp");
		mav.addObject("menuPage", "/patient/menu.jsp");
		mav.setViewName("/patient/mainTemp");
		return mav;
	}
	/**
	 * 注销
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/logout")
	public String logout()throws Exception{
		SecurityUtils.getSubject().logout(); 
		return "redirect: login.jsp";
	}
}
