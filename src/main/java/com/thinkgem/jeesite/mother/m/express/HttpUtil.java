package com.thinkgem.jeesite.mother.m.express;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class HttpUtil {
	private static String USER_AGENT = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; SLCC1; .NET CLR 2.0.50727; .NET CLR 3.0.04506; customie8)";

	// HTTP GET request
	public static String sendGet(String url, String charset,String appcode) throws Exception {
		CloseableHttpClient client = null;
		StringBuffer result = null;
		try {
			client = HttpClients.createDefault();
			HttpGet request = new HttpGet(url);

			// add request header
			request.addHeader("User-Agent", USER_AGENT);
			request.addHeader("Authorization","APPCODE "+appcode);

			HttpResponse response = client.execute(request);
			//System.out.println(response.getAllHeaders());
			// System.out.println("Response Code : " +
			 //response.getStatusLine().getStatusCode());
			BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), charset));

			result = new StringBuffer();
			String line = "";
			while ((line = rd.readLine()) != null) {
				result.append(line);
			}
			return result.toString();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			client.close();
		}
		
		return result.toString();
	}
}
