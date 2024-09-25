package org.techhub;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomerController {
	@RequestMapping("/cust")
	public String getcustomerpage()
	{
		return "customerlogin";
	}
}
