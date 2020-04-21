package edu.ysu.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import edu.ysu.entity.Doctor;
import edu.ysu.entity.Office;
import edu.ysu.entity.PageBean;
import edu.ysu.service.DoctorService;
import edu.ysu.service.OfficeService;
import edu.ysu.util.ResponseUtil;
import edu.ysu.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

@Controller
@RequestMapping("/office")
public class OfficeController {

	@Resource
	private OfficeService officeService;
	@Resource
	private DoctorService doctorService;
	
	/**
	 * 管理员查询所有科室信息
	 * @param userNo
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,
			@RequestParam(value="s_officeName",required=false)String officeName,@RequestParam(value="s_officeNo",required=false)String officeNo,
			@RequestParam(value="s_dirName",required=false)String dirName,
			HttpServletResponse response)throws Exception{
		Map<String,Object> map=new HashMap<String,Object>();
		if(StringUtil.isNotEmpty(page)&&StringUtil.isNotEmpty(rows)) {
			PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
			map.put("start", pageBean.getStart());
			map.put("size",pageBean.getRows());
		}
		if(StringUtil.isNotEmpty(officeName)){
		map.put("officeName", officeName);	
		}
		if(StringUtil.isNotEmpty(officeNo)){
			map.put("officeNo", officeNo);	
			}
		if(StringUtil.isNotEmpty(dirName)){
			map.put("dirName", dirName);	
			}
		List<Office> officeList=officeService.list(map);
		JSONObject result=new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONArray rows2=JSONArray.fromObject(officeList,jsonConfig);
		int total=officeService.count(map);
		result.put("total", total);
		result.put("rows", rows2);
		ResponseUtil.write(response, result);
		return null;
	}
	
	/**
	 * 下拉框动态加载所有科室信息
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/comboList")
	public String comboList(HttpServletResponse response)throws Exception{
		List<Office> officeList=officeService.list(null);
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONArray jsonArray=new JSONArray();
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("officeNo","");
		jsonObject.put("officeName","请选择科室......");
		jsonArray.add(jsonObject);
		jsonArray.addAll(JSONArray.fromObject(officeList,jsonConfig));
		ResponseUtil.write(response, jsonArray);
		return null;
	}
	
	/**
	 * 病人获取科室对应的所有医生
	 * @param userNo
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/info/{officeNo}")
	public ModelAndView details(@PathVariable("officeNo") String officeNo,HttpServletResponse response)throws Exception{
		Map<String,Object> map=new HashMap<String,Object>();
		if(StringUtil.isNotEmpty(officeNo)) {
			map.put("officeNo",officeNo);
		}
		Office office=officeService.findByNo(officeNo);
		ModelAndView mav=new ModelAndView();
		List<Doctor>doctorList=doctorService.list(map);
		mav.addObject("doctorList",doctorList);
		mav.addObject("officeName", office.getOfficeName());
		mav.addObject("menuPage", "/patient/menu.jsp");
		mav.addObject("mainPage","/patient/doctListAppoint.jsp");
		mav.setViewName("patient/mainTemp");
		return mav;
	}	
	/**
	 * 更新office信息或者添加office信息
	 * @param office
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(@RequestParam(value="id",required=false)String id,Office office,HttpServletResponse response)throws Exception{
		Integer addNums=0;
		JSONObject result=new JSONObject();
		if(StringUtil.isEmpty(id)) {
			 addNums=officeService.add(office);
		}else {
			addNums=officeService.update(office);
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
	 * 管理员批量删除科室
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
		int delNums=officeService.delete(map);
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
	 * 病人根据科室名称查询医生
	 * @param doctName
	 * @param keshiName
	 * @param sickName
	 * @param response
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/search")
	public ModelAndView search(@RequestParam(value="officeName",required=false)String officeName,HttpServletResponse response)throws Exception{
		Map<String,Object>map=new HashMap<String,Object>();
		ModelAndView mav=new ModelAndView();
		map.put("officeName", officeName);
		List<Office> officeList=officeService.search(map);
		Map<String,Object> map2=new HashMap<String,Object>();
		List<Doctor>doctorList=new ArrayList<Doctor>();
		for(Office office:officeList) {
			map2.put("officeNo", office.getOfficeNo());
			doctorList.addAll(doctorService.list(map2));
			map2.clear();
		}
		mav.addObject("doctList", doctorList);
		mav.setViewName("patient/searchDoct");
		return mav;
	}
}
