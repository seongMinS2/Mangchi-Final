package com.aia.mangh.mm.service;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailSenderService {
	@Autowired
	private JavaMailSender sender;

	public int send(String email, String code) {

		MimeMessage message = sender.createMimeMessage();

		try {
			message.setSubject("[인증안내] 이메일 인증을 해주세요.", "UTF-8");
			String htmlMsg = "<h2>인증번호:     "+code+"</h2>";
			message.setText(htmlMsg, "UTF-8", "html");
			message.setFrom(new InternetAddress("ryuyj@nate.com")); 
			message.addRecipient(RecipientType.TO, new InternetAddress(email, "고객님", "utf-8"));

			sender.send(message);

		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return 1;
	}

}
