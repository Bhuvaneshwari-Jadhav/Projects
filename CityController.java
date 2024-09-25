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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.techhub.model.CityModel;
import org.techhub.service.CityServiceImpl;

@Controller
public class CityController {

    @Autowired
    private CityServiceImpl cityServ;

    @RequestMapping("/city")
    public String getCityPage(Model model) {
        model.addAttribute("message", "");
        return "addcity";    
    }

    @PostMapping("/save")
    public String saveCity(@RequestParam("cname") String cityName, RedirectAttributes redirectAttributes) {
        if (cityServ.cityExists(cityName)) {
            redirectAttributes.addFlashAttribute("message", "City name already exists!");
            return "redirect:/city";
        } else {
            CityModel cityModel = new CityModel();
            cityModel.setCname(cityName);
            cityServ.saveCity(cityModel);
            redirectAttributes.addFlashAttribute("message", "City added successfully!");
            return "redirect:/city";
        }
    }

    @GetMapping("/checkCityName")
    @ResponseBody
    public String checkCityName(@RequestParam("cname") String cityName) {
        return cityServ.cityExists(cityName) ? "true" : "false";
    }

    public List<CityModel> viewAllCities() {
        return cityServ.getAllcity();
    }

    @RequestMapping("/deletebyid")
    public String deleteCityByID(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        cityServ.isDeleteCityByid(id);
        redirectAttributes.addFlashAttribute("message", "City deleted successfully!");
        return "redirect:/viewcitylist";
    }

    @RequestMapping("/updatebyid")
    public String showUpdateCityForm(@RequestParam("id") int id, Model model) {
        CityModel city = cityServ.getCityById(id);
        model.addAttribute("city", city);
        model.addAttribute("message", model.asMap().get("message")); // Pass message to the JSP
        return "updateCity";  // Corresponds to updateCity.jsp
    }

    @PostMapping("/saveupdate")
    public String updateCity(@ModelAttribute("city") CityModel cityModel, Model model) {
        if (cityServ.cityExists(cityModel.getCname())) {
            model.addAttribute("message", "City name already exists!");
            return "updateCity";  // Return to updateCity.jsp to show the message
        }

        boolean isUpdated = cityServ.isUpdateById(cityModel);
        if (isUpdated) {
            model.addAttribute("message", "City updated successfully!");
        } else {
            model.addAttribute("message", "Failed to update city. Please try again.");
        }
        return "updateCity";  // Return to updateCity.jsp to show the message
    }

    @RequestMapping(value = "/viewcitylist", method = RequestMethod.GET)
    public String viewAllCities(Map<String, Object> map) {
        map.put("clist", this.viewAllCities());
        return "viewcity";
    }

    @RequestMapping("/backgromupdate")
    public String backupdate() {
        return "viewcity";
    }
}
