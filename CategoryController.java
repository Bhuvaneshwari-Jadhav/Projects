package org.techhub;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.techhub.model.CategoryModel;
import org.techhub.service.CategoryService;

@Controller
public class CategoryController {

    @Autowired
    CategoryService catServ;

    @RequestMapping("/category")
    public String addCategory() {
        return "categories";
    }

    @RequestMapping(value = "/checkCategory", method = RequestMethod.POST)
    @ResponseBody
    public String checkCategory(@RequestParam("htype") String categoryName) {
        boolean exists = catServ.checkCategoryExists(categoryName);
        return "{\"exists\":" + exists + "}";
    }

    @RequestMapping(value = "/savecat", method = RequestMethod.POST)
    public String saveCategory(@Validated CategoryModel model, BindingResult result, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "categories";
        }

        boolean isAdded = catServ.isAddCategory(model);
        if (isAdded) {
            redirectAttributes.addFlashAttribute("msg", "Category added successfully.");
            redirectAttributes.addFlashAttribute("msgType", "success");
        } else {
            redirectAttributes.addFlashAttribute("msg", "Category not added. Maybe it already exists.");
            redirectAttributes.addFlashAttribute("msgType", "error");
        }
        return "redirect:/category";
    }

    @RequestMapping(value = "/viewcat", method = RequestMethod.GET)
    public String viewAllCategories(Map<String, Object> map) {
        List<CategoryModel> list = catServ.getCategory();
        map.put("catlist", list);
        return "viewcategory";
    }

    @RequestMapping("/deletebycatid")
    public String deleteCategory(@RequestParam("categoryid") int id, RedirectAttributes redirectAttributes) {
        catServ.DeleteCategory(id);
        redirectAttributes.addFlashAttribute("msg", "Category deleted successfully.");
        return "redirect:/viewcat";
    }
}
