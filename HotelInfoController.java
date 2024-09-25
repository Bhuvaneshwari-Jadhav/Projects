package org.techhub;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.techhub.model.AreaModel;
import org.techhub.model.CityModel;
import org.techhub.model.HotelModel;
import org.techhub.service.CategoryServiceImpl;
import org.techhub.service.CityServiceImpl;
import org.techhub.service.HotelServiceImpl;
import org.techhub.service.areaServiceImpl;

@Controller
public class HotelInfoController {

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

    @RequestMapping(value = "/addhotel", method = RequestMethod.GET)
    public String showAddHotelPage(@RequestParam(value = "id", required = false) Integer id, Model model) {
        model.addAttribute("clist", viewAllCities());  // Populate city list
        model.addAttribute("catlist", catServ.getCategory());  // Populate category list
        
        if (id != null && id != 0) {
            List<AreaModel> areas = aserv.getAllAreaByCity(id);
            model.addAttribute("alist", areas);  // Populate area list if city ID is provided
        } else {
            model.addAttribute("alist", Collections.emptyList());  // Ensure 'alist' is always present
        }

        return "addhotel";  // Return to the add hotel JSP page
    }

    @RequestMapping(value = "/getAreasByCity", method = RequestMethod.GET)
    @ResponseBody
    public List<AreaModel> getAreasByCity(@RequestParam("id") int id) {
        return aserv.getAllAreaByCity(id);  // Return list of areas based on city ID
    }

    @RequestMapping(value = "/getHotelsByArea", method = RequestMethod.GET)
    @ResponseBody
    public List<HotelModel> getHotelsByArea(@RequestParam("aid") int areaId) {
        return hserv.getHotelsByArea(areaId);  // Return list of hotels based on area ID
    }

    @RequestMapping(value = "/savehotel", method = RequestMethod.POST)
    public String saveHotel(@RequestParam("id") int id, @RequestParam("aid") int aid,
                            @RequestParam("categoryid") int categoryid,
                            @RequestParam("hotelName") String hotelName,
                            @RequestParam("hotelcontact") String contact, 
                            @RequestParam("hotelAddress") String address,
                            @RequestParam("pincode") int pincode, 
                            @RequestParam("price") int price,
                            @RequestParam("rating") int rating,
                            @RequestParam("reviews") String review,
                            @RequestParam("image") String image,
                            Model model) {
        // Save the hotel
        boolean isAdded = hserv.addHotel(id, aid, categoryid, hotelName, contact, address, pincode, price, rating, review, image);
        
        if (isAdded) {
            model.addAttribute("msg", "Hotel added successfully!");
        } else {
            model.addAttribute("msg", "Failed to add hotel. Please try again.");
        }

        return "addhotel";  // Return to the add hotel JSP page with a message
    }

    @GetMapping("/viewhotel")
    public String viewHotel(@RequestParam(value = "id", required = false) Integer id, 
                            @RequestParam(value = "aid", required = false) Integer aid, 
                            
                            Model model) {
        // Populate city list
        model.addAttribute("clist", cityServ.getAllcity());
        
        // Populate area list based on selected city
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

        return "viewhotel"; // Return to the view hotel JSP page
    }
  
    
    @GetMapping("/deleteHotelbyHid")
    public ModelAndView deleteHotelById(@RequestParam("hotelid") int hotelid) {
    
        // Call your service method to delete the hotel
        boolean isDeleted = hserv.isDeleteHotelById(hotelid);

        // Prepare the ModelAndView object
        ModelAndView mav = new ModelAndView("viewhotel");

        if (isDeleted) {
            // If deletion is successful, add success message
            mav.addObject("successMessage", "Hotel deleted successfully.");
        } else {
            // If deletion fails, add error message
            mav.addObject("errorMessage", "Failed to delete the hotel. Please try again.");
        }

        // Fetch and add updated lists for the view
        mav.addObject("hlist", hserv.getHotelsByArea(hotelid)); // Fetch updated hotel list by area
        mav.addObject("alist", aserv.ViewAllAreas()); // Fetch updated list of areas
        mav.addObject("clist", cityServ.getAllcity()); // Fetch updated list of cities

        return mav;
    }
    
    @RequestMapping("/updatehotelbyid")
    public String updatePage(HotelModel hmodel,Model model)
    {
    	return "updatehotel";
    }
    
    @RequestMapping("/saveupdatedhotel")
    public String getUppdatedpage( @RequestParam("hotelName") String hotelName,
            @RequestParam("hotelcontact") String contact, 
            @RequestParam("hotelAddress") String address,
            @RequestParam("pincode") int pincode, 
            @RequestParam("price") int price,
            @RequestParam("rating") int rating,
            @RequestParam("reviews") String review,
            @RequestParam("image") String image,
            @RequestParam("hotelid") int hotelid,
            Model model) {
    	boolean b=hserv.updatehotelbyid(hotelName,contact,address,pincode,price,rating,review,image,hotelid);
    if(b)
    {
    	model.addAttribute("msg"," hotel updated successfully");
    }
    else
    {
    	model.addAttribute("msg", "some problem is there ");
    }
    	return "updatehotel";
    }
    
    

}
