package edu.ysu.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import edu.ysu.entity.Doctor;
import edu.ysu.entity.PageBean;
import edu.ysu.service.DoctorService;
import edu.ysu.service.OfficeService;
import edu.ysu.util.StringUtil;

@Controller
@RequestMapping("/search")
public class SearchController {

	@Resource
	private OfficeService officeService;
	@Resource
	private DoctorService doctorService;
	
	/**
	 * 病人根据科室名称，医生姓名来综合查询医生信息
	 * @param officeName
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView search(@RequestParam(value="officeName",required=false)String officeName,@RequestParam(value="doctName",required=false)String doctName,
			@RequestParam(value="page",required=false)String currentPage,
			HttpServletRequest request,HttpServletResponse response)throws Exception{
		Map<String,Object>map=new HashMap<String,Object>();
		if(StringUtil.isEmpty(currentPage)) {
			currentPage="1";
		}
		PageBean pageBean=new PageBean(Integer.parseInt(currentPage),5);
		ModelAndView mav=new ModelAndView();
		map.put("officeName", officeName);
		map.put("doctName", doctName);
		map.put("start",pageBean.getStart());
		map.put("size",pageBean.getRows());
		List<Doctor> doctList=doctorService.search2(map);
		int totalNum=doctorService.count(map);
		String pageCode=this.getUpAndDownPageCode(pageBean.getPage(), totalNum, pageBean.getRows(),request.getServletContext().getContextPath(),officeName,doctName);
		mav.addObject("doctList", doctList);
		mav.addObject("pageCode", pageCode);
		mav.setViewName("patient/searchDoct");
		return mav;
	}
	
	/**
	 * 获取分页代码
	 * @param page
	 * @param totalNum
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public String getUpAndDownPageCode(Integer currentPage,Integer totalNum,Integer pageSize,String projectContext,String officeName,String doctName)throws Exception{
		String searchStr="officeName="+officeName+"&doctName="+doctName;
		int totalPage=totalNum%pageSize==0?totalNum/pageSize:totalNum/pageSize+1;
		StringBuffer pageCode=new StringBuffer();
		if(currentPage==1) {
			pageCode.append("<li class='disabled'><a href='#'>首页</a></li>");
			pageCode.append("<li class='disabled'><a href='#'>上一页</a></li>");

		}else {
			pageCode.append("<li class='active'><a href='"+projectContext+"/search/list.do?page=1&"+searchStr+"'>首页</a></li>");
			pageCode.append("<li class='active'><a href='"+projectContext+"/search/list.do?page="+(currentPage-1)+"&"+searchStr+"'>上一页</a></li>");
		}
				if(currentPage>=5) {
					for(int j=3;j>=1;j--) {
				pageCode.append("<li class='active'><a href='"+projectContext+"/search/list.do?page="+(currentPage-j)+"&"+searchStr+"'>"+(currentPage-j)+"</a></li>");
					}
				}
				pageCode.append("<li class='disabled'><a href='#'>"+currentPage+"</a></li>");	
				if(currentPage<=totalPage-3) {
					for(int j=1;j<=3;j++) {
		  	pageCode.append("<li class='active'><a href='"+projectContext+"/search/list.do?page="+(currentPage+j)+"&"+searchStr+"'>"+(currentPage+j)+"</a></li>");
					}
				}
		if(currentPage==totalPage) {
			pageCode.append("<li class='disabled'><a href='#'>下一页</a></li>");
			pageCode.append("<li class='disabled'><a href='#'>尾页</a></li>");
		}else {
			pageCode.append("<li class='active'><a href='"+projectContext+"/search/list.do?page="+(currentPage+1)+"&"+searchStr+"'>下一页</a></li>");
			pageCode.append("<li class='active'><a href='"+projectContext+"/search/list.do?page="+totalPage+"&"+searchStr+"'>尾页</a></li>");
		}
		return pageCode.toString();
	}
}
