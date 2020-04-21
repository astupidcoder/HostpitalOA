package edu.ysu.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.ysu.entity.Appoint;
import edu.ysu.entity.Doctor;
import edu.ysu.entity.Patient;
import edu.ysu.service.AppointService;
import edu.ysu.service.DoctorService;
import edu.ysu.service.PatientService;
import edu.ysu.util.ResponseUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/appoint")
public class AppointController {

	@Resource
	private AppointService appointService;
	@Resource
	private DoctorService doctorService;
	@Resource
	private PatientService patientService;
	/**
	 * 挂号
	 * @param p_userNo
	 * @param d_userNo
	 * @param doctor
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/update")
	public String appoint(@RequestParam(value="p_userNo")String p_userNo,@RequestParam(value="doctNo")String doctNo,
			HttpServletResponse response,HttpSession session)throws Exception{
		
		Appoint appoint=null;
		int addNum=0;
		Doctor doctor=doctorService.getByUserNo(doctNo);
		Patient patient=patientService.getByUserNo(p_userNo);
		if(patient!=null&doctor!=null) {
			 appoint=new Appoint(patient,doctor,"已预约");
		}
		JSONObject result=new JSONObject();
		addNum=appointService.update(appoint);
		if(addNum==2) {
			result.put("success","true");
			Patient currentUser=patientService.getByUserNo(p_userNo);
			session.setAttribute("currentUser",currentUser);
			session.setAttribute("doctor", doctor);
		}else {
			result.put("errorMsg","挂号失败");
		}
		ResponseUtil.write(response, result);
		return null;
	}	
}
