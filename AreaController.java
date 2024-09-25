package org.techhub;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.techhub.model.AreaModel;
import org.techhub.model.CityModel;
import org.techhub.service.CityServiceImpl;
import org.techhub.service.areaService;

@Controller
public class AreaController {

    @Autowired
    private CityServiceImpl cityServ;

    @Autowired
    private areaService aserv;

    // Method to view all cities
    public List<CityModel> viewAllCities() {
        List<CityModel> list = cityServ.getAllcity();
        return list;
    }

    // Get area page
    @RequestMapping("/area")
    public String getAreaPage(Model model) {
        model.addAttribute("clist", this.viewAllCities());
        return "addarea";    
    }

    // Save new area
    @RequestMapping(value = "/savearea", method = RequestMethod.POST)
    public String saveArea(AreaModel amodel, CityModel cmodel, Map<String, String> map) {
        String areaName = amodel.getAname();
        if (areaName == null || areaName.isEmpty() || areaName.matches(".*\\d.*")) {
            map.put("msg", "Invalid area name. Please ensure it contains no digits and is not empty.");
            return "addarea";
        }

        boolean isDuplicate = aserv.isAreaDuplicate(amodel.getAname(), cmodel.getId());
        if (isDuplicate) {
            map.put("msg", "Area name already exists in this city.");
            return "addarea";
        }

        boolean isAdded = this.aserv.isAddNewArea(amodel, cmodel);
        if (isAdded) {
            map.put("msg", "New Area added successfully.");
        } else {
            map.put("msg", "Failed to add Area.");
        }

        return "addarea";
    }

    // View areas by city
    @RequestMapping(value = "/viewareabycity", method = RequestMethod.GET)
    public String viewAreaByCity(@RequestParam(value = "id", required = false, defaultValue = "0") int cityId, Model model) {
        model.addAttribute("clist", this.viewAllCities());
         
        if (cityId != 0) {
            List<AreaModel> areas = aserv.getAllAreaByCity(cityId);
            model.addAttribute("alist", areas);
        }
       
        return "viewarea";
    }

    // Delete area by ID
    
    @GetMapping("/DeleteAreaById")
    public ModelAndView deleteAreaById(@RequestParam("aid") int aid) {
        // Call your service method to delete the area
        boolean isDeleted = aserv.DeleteAreaById(aid);

        // Return the updated list of areas
        ModelAndView mav = new ModelAndView("viewarea");
        mav.addObject("alist", aserv.ViewAllAreas()); // Fetch updated list
        mav.addObject("clist", cityServ.getAllcity()); // Fetch city list if needed

        return mav;
    }
  
    
    
    // Get update area page
    @RequestMapping(value="/updateareabyaid")
    public String getupdatePage( @RequestParam("aid") int aid ,Model model,AreaModel amodel) {
    	
        model.addAttribute("aid",amodel.getAid());
        model.addAttribute("aname",amodel.getAname());
        return "updatearea";
    }


    @PostMapping("/areaupdated")
    public String updateArea(@RequestParam("aid")int aid,
                             @RequestParam("aname") String aname,
                             Model model,AreaModel amodel) {
    	boolean isUpdated = aserv.updateArea(aid,aname);
      if (isUpdated) {
          model.addAttribute("msg", "area updated successfully!");
      } else {
          model.addAttribute("msg", "Failed to update area. Please try again.");
      }  
    
         
        return "updatearea"; // Return to the same page with messages
    }

    @RequestMapping("/backfromarea")
    public String getBack()
    {
    	return "adminpro";
    }
}
