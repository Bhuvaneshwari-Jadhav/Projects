package org.techhub;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.techhub.model.AdminModel;
import org.techhub.model.AreaModel;
import org.techhub.model.CityModel;
import org.techhub.model.HotelModel;
import org.techhub.service.CategoryServiceImpl;
import org.techhub.service.CityServiceImpl;
import org.techhub.service.HotelServiceImpl;
import org.techhub.service.adminService;
import org.techhub.service.areaServiceImpl;

@Controller
public class HomeController {
	
	@Autowired
	private HotelServiceImpl hserv;

	@Autowired
	private CityServiceImpl cityServ;

	@Autowired
	private CategoryServiceImpl catServ;

	@Autowired
	private areaServiceImpl aserv;

	private List<CityModel> viewAllCities() {
		return cityServ.getAllcity();
	}
	@Autowired
	adminService loginserviceImpl;

	@RequestMapping(value = "/")
	public String getRecommendationPage(@RequestParam(value = "id", required = false) Integer id,
			@RequestParam(value = "aid", required = false) Integer aid, Model model) {
		model.addAttribute("clist", viewAllCities()); // Populate city list
		 if (id != null && id != 0) {
	            List<AreaModel> areas = aserv.getAllAreaByCity(id);
	            model.addAttribute("alist", areas);
	        } else {
	            model.addAttribute("alist", Collections.emptyList());
	        }

	        // Populate hotel list based on selected area
	        if (aid != null && aid != 0) {
	            List<HotelModel> hotels = hserv.getHotelsByArea(aid);
	            model.addAttribute("hlist", hotels);
	        } else {
	            model.addAttribute("hlist", Collections.emptyList());
	        }

        
		return "index";
	}
//
//	@RequestMapping("/custarea")
//	public String getareaPage(@RequestParam(value = "id", required = false) Integer id,
//			@RequestParam(value = "aid", required = false) Integer aid, Model model) {
//		if (id != null && id != 0) {
//			List<AreaModel> areas = aserv.getAllAreaByCity(id);
//			model.addAttribute("alist", areas); // Populate area list if city ID is provided
//		} else {
//			model.addAttribute("alist", Collections.emptyList()); // Ensure 'alist' is always present
//		}
//		return "areas";
//	}
//	@RequestMapping("/custhotel")
//	public String gethotelPage(@RequestParam(value = "id", required = false) Integer id,
//			@RequestParam(value = "aid", required = false) Integer aid, Model model) {
//		
//		if (aid != null && aid != 0) {
//			List<HotelModel> hotels = hserv.getHotelsByArea(aid); // Fetch hotels based on area ID
//			model.addAttribute("hlist", hotels); // Add hotels to the model
//		} else {
//			model.addAttribute("hlist", Collections.emptyList()); // Ensure 'hlist' is always present
//		}
//		return "custhotel";
//	}
//	
	
	@RequestMapping(value = "/ad")
	public String getAdmin() {
		return ("admin");
	}

	@RequestMapping(value = "/validate", method = RequestMethod.POST)
	public String masterPage(@RequestParam("uname") String name, @RequestParam("password") String pawd, Map map) {

//		System.out.println(name + ":" + pawd);
		AdminModel model = new AdminModel();
		model.setUname(name);
		model.setPassword(pawd);
		boolean b = loginserviceImpl.isgetLogin(model);
//		System.out.println(b);
		if (b) {
//			map.put("msg", "Login Sucessfully...");
			return "adminpro";
//			return "profile";
		} else {
			map.put("msg", "Invalid username and password");
			return "admin";
		}
		
	}
	@RequestMapping("/back")
	public String getBack()
	{
		return "adminpro";
	}
	
	
}
