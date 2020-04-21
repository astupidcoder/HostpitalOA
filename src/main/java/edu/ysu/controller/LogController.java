package edu.ysu.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import edu.ysu.entity.Log;
import edu.ysu.entity.PageBean;
import edu.ysu.service.LogService;
import edu.ysu.util.DateUtil;
import edu.ysu.util.ResponseUtil;
import edu.ysu.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

/**
 * 医生日志controller
 * @author lyj
 *
 */
@Controller
@RequestMapping("/log")
public class LogController {

	@Resource
	private LogService logService;
	
	/**
	 * 上传工作日志
	 * @param logFile
	 * @param doctor
	 * @param response
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/upload")
	public String upload(@RequestParam("file")MultipartFile logFile,Log log,HttpServletResponse response,HttpServletRequest request)throws Exception{
		if(!logFile.isEmpty()){
			String filePath=request.getServletContext().getRealPath("/");
			System.out.println(filePath);
			System.out.println(logFile.getOriginalFilename());
			String logName=DateUtil.getCurrentDateStr()+"."+logFile.getOriginalFilename().split("\\.")[1];
			//String logName=logFile.getOriginalFilename();
			logFile.transferTo(new File(filePath+"static/log/"+logName));
			System.out.println(filePath);
			log.setLogName(logName);
		}
		int resultTotal=logService.add(log);
		StringBuffer result=new StringBuffer();
		if(resultTotal>0){
			result.append("<script language='javascript'>alert('上传成功！');</script>");
		}else{
			result.append("<script language='javascript'>alert('上传失败！');</script>");
		}
		/*JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONObject json=JSONObject.fromObject(result,jsonConfig);
		
		ResponseUtil.write(response, json);*/
		JSONObject json=new JSONObject();
		json.put("code", 0);
		json.put("msg","yes");
		json.put("data","true");
		ResponseUtil.write(response, json);
		return null;
	}
	
	/**
	 * 查询日志
	 * @param page
	 * @param rows
	 * @param userNo
	 * @param userName
	 * @param officeNo
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="limit",required=false)String limit,
			@RequestParam(value="userNo",required=false)String userNo,
			HttpServletResponse response)throws Exception{
		Map<String,Object> map=new HashMap<String,Object>();
		if(StringUtil.isNotEmpty(page)&&StringUtil.isNotEmpty(limit)) {
			PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(limit));
			map.put("start", pageBean.getStart());
			map.put("size",pageBean.getRows());
		}
		if(StringUtil.isNotEmpty(userNo)) {
			map.put("userNo", userNo);
		}
		List<Log> logList=logService.list(map);
		
		JSONObject result=new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONArray data=JSONArray.fromObject(logList,jsonConfig);
		int count=logService.count(map);
		result.put("code",0);
		result.put("count", count);
		result.put("data",data);
		result.put("msg","yes");
		ResponseUtil.write(response, result);
		return null;
	}
	
	/**
	 * 日志的下载
	 * @param id
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/download")
	public String download(@RequestParam("id")Integer id,HttpServletResponse response)	throws Exception
	{
		String dirpath="D:\\eclipse-jee-photon-R-win32-x86_64\\projects\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\HosptialOA\\static\\log\\";
		File f1=new File(dirpath);   //查找对应学号的文件
		String s[]=f1.list();
		String filedownload="";
		String filedisplay="";
		String logName=logService.getLogById(id).getLogName(); //获取文件名
		for(int i=0;i<s.length;i++) {
			if(s[i].equals(logName))
			{
				System.out.println(s[i]);
				 filedownload=dirpath+s[i];
				 filedisplay=s[i];
				 System.out.println("文件名："+filedisplay);break;
			}
		}
response.setContentType("application/x-download");
System.out.println("文件："+filedisplay);
// response.addHeader("Content-Disposition","attachment;filename="+filedisplay);
response.setHeader("Content-Disposition", "attachment;filename=" + new String(filedisplay.getBytes("utf-8"),"ISO8859_1"));
InputStream is=null;
OutputStream os=null;
BufferedInputStream bis=null;
BufferedOutputStream bos=null;
is=new FileInputStream(new File(filedownload));
bis=new BufferedInputStream(is);
os=response.getOutputStream();
bos=new BufferedOutputStream(os);
byte[] b=new byte[1024];
int len=0;
while((len=bis.read(b))!=-1) {
		  bos.write(b,0,len);
}
bis.close();
is.close();
bos.close();
os.close();
return null;
	}
	
	
	
	
	
	/*
	*//**
	 * 显示联系人列表
	 * @param userNo
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping("/list")
	public String contact(@RequestParam(value="userNo")String userNo,HttpServletRequest request,HttpServletResponse response)throws Exception{
		Map<String,Object> map=new HashMap<String,Object>();
		List<Doctor> doctList=new ArrayList<Doctor>();
		if(StringUtil.isNotEmpty(userNo)) {
			map.put("userNo",userNo);
			doctList=contactService.list(map);
		}

		JSONObject result=new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONArray rows2=JSONArray.fromObject(doctList,jsonConfig);
		int total=contactService.count(map);
		result.put("count", total);
		result.put("rows", rows2);
		ResponseUtil.write(response, result);
		return null;
	}	*/
}
