package org.techhub;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.techhub.model.AreaModel;
import org.techhub.model.CityModel;
import org.techhub.model.HotelModel;
import org.techhub.service.CategoryServiceImpl;
import org.techhub.service.CityServiceImpl;
import org.techhub.service.HotelServiceImpl;
import org.techhub.service.areaServiceImpl;

@Controller
public class customercontro {
	@RequestMapping("/cutmer")
	public String getCustomerpage() {
		return "camecust";
	}

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

	@RequestMapping("/custpage")
	public String getRecommendationPage(@RequestParam(value = "id", required = false) Integer id,
			@RequestParam(value = "aid", required = false) Integer aid, Model model) {
		model.addAttribute("clist", viewAllCities()); // Populate city list
		model.addAttribute("catlist", catServ.getCategory()); // Populate category list

		if (id != null && id != 0)
		{
			List<AreaModel> areas = aserv.getAllAreaByCity(id);
			model.addAttribute("alist", areas); // Populate area list if city ID is provided
		} else {
			model.addAttribute("alist", Collections.emptyList()); // Ensure 'alist' is always present
		}

		if (aid != null && aid != 0) {
			List<HotelModel> hotels = hserv.getHotelsByArea(aid); // Fetch hotels based on area ID
			model.addAttribute("hlist", hotels); // Add hotels to the model
		} else {
			model.addAttribute("hlist", Collections.emptyList()); // Ensure 'hlist' is always present
		}

		return "recommandpage";
	}
}
