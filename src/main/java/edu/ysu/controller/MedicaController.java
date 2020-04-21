package edu.ysu.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.ysu.entity.MedicaInfo;
import edu.ysu.entity.PageBean;
import edu.ysu.service.MedicaService;
import edu.ysu.util.ResponseUtil;
import edu.ysu.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

@Controller
@RequestMapping("/medica")
public class MedicaController {

	@Resource
	private MedicaService medicaService;
	
	@RequestMapping("/list")
	public String list(
			@RequestParam(value="searchName",required=false)String searchName,
			@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String limit,
			HttpServletRequest request,HttpServletResponse response)throws Exception{
		Map<String,Object> map=new HashMap<String,Object>();
		List<MedicaInfo> medicaList=new ArrayList<MedicaInfo>();
		if(StringUtil.isNotEmpty(searchName)) {
			map.put("searchName", searchName);
		}
		if(StringUtil.isNotEmpty(page)&&StringUtil.isNotEmpty(limit)) {
			PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(limit));
			map.put("start", pageBean.getStart());
			map.put("size",pageBean.getRows());
		}
		medicaList=medicaService.list(map);

		JSONObject result=new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONArray rows=JSONArray.fromObject(medicaList,jsonConfig);
		int total=medicaService.count(map);
		result.put("total", total);
		result.put("rows", rows);
		ResponseUtil.write(response, result);
		return null;
	}	
	/**
	 * 更新和添加联系人
	 * @param id
	 * @param doctor
	 * @param response
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping("/save")
	public String save(Contact contact,@RequestParam("flag")String flag, HttpServletResponse response)throws Exception{
		JSONObject result=new JSONObject();
		Integer val=0;
		if(flag.equals("0")) {
			val=contactService.add(contact);
		}else {
			val=contactService.update(contact);
		}
		if(val==1) {
			result.put("success","true");
	
		}else {
			result.put("success","false");
		}
		ResponseUtil.write(response, result);
		return null;
	}	
	*/
	
	/**
	 * 删除药品信息
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
		int delNums=medicaService.delete(map);
		if(delNums>0) {
			result.put("success", "true");
			result.put("delNums", delNums);
		}else {
			result.put("errorMsg", "删除失败");
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	
}
