package com.aia.mangh.mm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberVerifyService {

	@Autowired
	private MailSenderService mailService;
	
	public int reMailSend(String email, String code) {
				
		mailService.send(email, code);
		
		return 1;
	}
}
