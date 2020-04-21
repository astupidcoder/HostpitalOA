package edu.ysu.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import edu.ysu.entity.Appoint;
import edu.ysu.entity.Doctor;
import edu.ysu.entity.Office;
import edu.ysu.entity.PageBean;
import edu.ysu.entity.Patient;
import edu.ysu.service.AppointService;
import edu.ysu.service.DoctorService;
import edu.ysu.service.OfficeService;
import edu.ysu.util.DateUtil;
import edu.ysu.util.ResponseUtil;
import edu.ysu.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

@Controller
@RequestMapping("/doctor")
public class DoctorController {

	@Resource
	private DoctorService doctorService;
	@Resource
	private OfficeService officeService;
	@Resource
	private AppointService appointService;
	/**
	 * 登录
	 */
	@RequestMapping("/login")
	public String login(Doctor doctor,HttpServletRequest request,HttpSession session)throws Exception{
		try{
			Doctor doc=doctorService.getByUserNo(doctor.getUserNo());
			if((doc==null)||!(doc.getPassword().equals(doctor.getPassword()))) {
				request.setAttribute("doctor", doctor);
				request.setAttribute("errorInfo", "用户名或者密码错误!!！");	
				return "doctor/login";
			}else {
				session.setAttribute("currentUser", doc);  //将当前登录的用户信息放入session中
				//request.setAttribute("menuPage", "/doctor/menu.jsp");
				return "doctor/main";
			}
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("doctor", doctor);
			request.setAttribute("errorInfo", "用户名或者密码错误le！");
			return "doctor/login";
		}
	}
	
	/**
	 * 通过userNo查找对象，并返回对象实体
	 */
	@RequestMapping("/find")
	public String find(@RequestParam("userNo")String userNo,HttpServletResponse response)throws Exception{
		Doctor doc=doctorService.getByUserNo(userNo);
		System.out.println(userNo);
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONObject json=JSONObject.fromObject(doc,jsonConfig);
		ResponseUtil.write(response, json);
		return null;
	}
	
	/**
	 * 医生查看自己所有的病人信息
	 * @param userNo
	 * @param page
	 * @param limit
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/look")
	public String look(@RequestParam(value="userNo")String userNo,
			@RequestParam(value="page",required=false)String page,@RequestParam(value="limit",required=false)String limit,
			HttpServletRequest request,HttpServletResponse response)throws Exception{
		Map<String,Object> map=new HashMap<String,Object>();
		List<Appoint> appointList=new ArrayList<Appoint>();
		if(StringUtil.isNotEmpty(page)&&StringUtil.isNotEmpty(limit)) {
			PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(limit));
			map.put("start", pageBean.getStart());
			map.put("size",pageBean.getRows());
		}
		List<Patient> patientList=new ArrayList<Patient>();
		if(StringUtil.isNotEmpty(userNo)) {
			map.put("userNo",userNo);
			appointList=appointService.getPatientByUserNo(map);
			for(Appoint appoint:appointList) {
				patientList.add(appoint.getPatient());
			}
		}
		JSONObject result=new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONArray rows=JSONArray.fromObject(patientList,jsonConfig);
		
		for(int i=0;i<rows.size();i++) {
			JSONObject o=JSONObject.fromObject(appointList.get(i).getDate());
			rows.getJSONObject(i).put("date", o);
		}
		for(int i=0;i<rows.size();i++) {
			System.out.println(rows.getJSONObject(i));
		}
		
		int total=appointService.countPatient(userNo);
		result.put("total", total);
		result.put("rows", rows);
		result.put("message","yes");
		result.put("status", 200);
		ResponseUtil.write(response, result);
		return null;
	}	
	
	
	/**
	 * 医生自己修改医生个人信息
	 * @param imageFile
	 * @param doctor
	 * @param response
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(@RequestParam("imageFile")MultipartFile imageFile,Doctor doctor,HttpServletResponse response,HttpServletRequest request)throws Exception{
		if(!imageFile.isEmpty()){
			String filePath=request.getServletContext().getRealPath("/");
			String imageName=DateUtil.getCurrentDateStr()+"."+imageFile.getOriginalFilename().split("\\.")[1];
			imageFile.transferTo(new File(filePath+"static/userImages/"+imageName));
			doctor.setImageName(imageName);
		}
		int resultTotal=doctorService.update(doctor);
		StringBuffer result=new StringBuffer();
		if(resultTotal>0){
			result.append("<script language='javascript'>alert('修改成功！');</script>");
		}else{
			result.append("<script language='javascript'>alert('修改失败！');</script>");
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	/**
	 * 病人查询对应科室的所有医生
	 * @param userNo
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletResponse response)throws Exception{

		ModelAndView mav=new ModelAndView();
		List<Doctor> doctorList=doctorService.list(null);
		List<Office> officeList=officeService.list(null);
		mav.addObject("doctorList", doctorList);
		mav.addObject("officeList",officeList);
		mav.addObject("menuPage", "/patient/menu.jsp");
		mav.addObject("mainPage","/patient/officeListAppoint.jsp");
		mav.setViewName("patient/mainTemp");
		return mav;
	}
	
	/**
	 * 按医生名称查询医生
	 * @param doctName
	 * @param keshiName
	 * @param sickName
	 * @param response
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/search")
	public ModelAndView search(@RequestParam(value="doctName",required=false)String doctName,@RequestParam(value="keshiName",required=false)String keshiName,@RequestParam(value="sickName",required=false)String sickName,HttpServletResponse response,HttpServletRequest request)throws Exception{
		ModelAndView mav=new ModelAndView();
		List<Doctor> doctList=doctorService.search(doctName);
		mav.addObject("doctList", doctList);
		mav.setViewName("patient/searchDoct");
		return mav;
	}
	
	
	/**
	 * 获取医生个人信息详情
	 * @param userNo
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/info/{userNo}")
	public ModelAndView details(@PathVariable("userNo") String userNo,HttpServletResponse response)throws Exception{
		ModelAndView mav=new ModelAndView();
		Doctor doct=doctorService.getByUserNo(userNo);
		mav.addObject("doct",doct);
		//mav.addObject("menuPage", "/patient/menu.jsp");
		//mav.addObject("mainPage","/doctor/info.jsp");
		//mav.setViewName("patient/mainTemp");
		mav.setViewName("/doctor/info");
		return mav;
	}
	
	/**
	 * 管理员查询所有医生
	 * @param userNo
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/manage/list")
	public String list2(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,
			@RequestParam(value="s_userNo",required=false)String userNo,
			@RequestParam(value="s_doctName",required=false)String userName,
			@RequestParam(value="s_officeNo",required=false)String officeNo,
			HttpServletResponse response)throws Exception{
		Map<String,Object> map=new HashMap<String,Object>();
		if(StringUtil.isNotEmpty(page)&&StringUtil.isNotEmpty(rows)) {
			PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
			map.put("start", pageBean.getStart());
			map.put("size",pageBean.getRows());
		}
		if(StringUtil.isNotEmpty(userNo)) {
			map.put("userNo", userNo);
		}
		if(StringUtil.isNotEmpty(userName)) {
			map.put("userName", userName);
		}
		if(StringUtil.isNotEmpty(officeNo)) {
			map.put("officeNo", officeNo);
		}
		List<Doctor> doctorList=doctorService.list(map);
		
		JSONObject result=new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONArray rows2=JSONArray.fromObject(doctorList,jsonConfig);
		int total=doctorService.count(null);
		result.put("total", total);
		result.put("rows", rows2);
		ResponseUtil.write(response, result);
		return null;
	}
	
	/**
	 * 管理员更新或添加Doctor信息
	 * @param id
	 * @param doctor
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/manage/save")
	public String save2(@RequestParam(value="id",required=false)String id,Doctor doctor,HttpServletResponse response)throws Exception{
		Integer addNums=0;
		JSONObject result=new JSONObject();
		if(StringUtil.isEmpty(id)) {
			 addNums=doctorService.add(doctor);
		}else {
			addNums=doctorService.update(doctor);
		}
		if(addNums==1) {
			result.put("success","true");
		}else {
			result.put("errorMsg","保存失败了了");
		}
		ResponseUtil.write(response, result);
		return null;
	}	
	/**
	 * 管理员批量删除医生
	 * @param delIds
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="delIds",required=false)String delIds,HttpServletResponse response)throws Exception{
		JSONObject result=new JSONObject();
		Map<String,Object> map=new HashMap<String,Object>();
		List<Integer>idList=new ArrayList<Integer>();
		String str[]=delIds.split(",");
		for(int i=0;i<str.length;i++) {
          idList.add(Integer.parseInt(str[i]));
		}
		map.put("idList", idList);
		int delNums=doctorService.delete(map);
		if(delNums>0) {
			result.put("success", "删除成功");
			result.put("delNums", delNums);
		}else {
			result.put("errorMsg", "删除失败");
		}
		ResponseUtil.write(response, result);
		return null;
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
