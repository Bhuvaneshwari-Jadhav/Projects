package org.techhub;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.techhub.model.bookModel;
import org.techhub.service.bookServiceImpl;

@Controller
public class BookController {
@Autowired
bookServiceImpl bser;
	@RequestMapping("/book")
	public String BookHotel()
	{
		return "booking";
	}
	@RequestMapping("/infosave")
	public String bookhotel(bookModel model,Model map)
	{
		boolean b=bser.isBookHotel(model);
		if(b)
		{
			 map.addAttribute("msg", "Hotel book successfully");
		}
		else
		{
			 map.addAttribute("msg", "hotel not book");
		}
		return "booking";
		
	}
}
