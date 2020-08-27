package com.aia.mangh.mm.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class KakaoMemberService {

	// 카카오 로그아웃
	public void kakaoLogout(String access_Token) {

		System.out.println("logout token: " + access_Token);
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String result = "";
			String line = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 카카오 연결끊기
	public void kakaoUnlink(String access_Token) {

		System.out.println("logout token: " + access_Token);
		String reqURL = "https://kapi.kakao.com/v1/user/unlink";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String result = "";
			String line = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 카카오 프로필 업데이트
	public String getUpdateProfile(String access_Token) {
		String reqURL = "https://kapi.kakao.com/v1/api/talk/profile";
		String mImg = null;
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String result = "";
			String line = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			System.out.println("response body profile: " + result);

			String profile = element.getAsJsonObject().get("profileImageURL").getAsString();
			System.out.println("json profile:" + profile);

			mImg = profile;

			if (mImg.isEmpty()) {
				mImg = "defalult.png";
			}

			System.out.println("string mImg:" + mImg);

		} catch (IOException e) {
			e.printStackTrace();
		}
		return mImg;
	}

	// 카카오 메세지보내기
	public String sendMessage(String access_Token, String code) {

		final String HOST = "https://kapi.kakao.com";
		
		RestTemplate restTemplate = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + access_Token);
		
		JsonObject template_object = new JsonObject();
		JsonObject jsonlink = new JsonObject();

		jsonlink.addProperty("web_url", "https://developers.kakao.com");
		jsonlink.addProperty("mobile_web_url", "https://developers.kakao.com");

		template_object.addProperty("object_type", "text");
		template_object.addProperty("text", "회원탈퇴 인증번호 >> "+code);
		template_object.add("link", jsonlink);
		template_object.addProperty("button_title", "button");
		 
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("template_object", template_object.toString());
		
		HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
		
		try {
			restTemplate.postForLocation(new URI(HOST + "/v2/api/talk/memo/default/send"), body);
		} catch (RestClientException | URISyntaxException e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
