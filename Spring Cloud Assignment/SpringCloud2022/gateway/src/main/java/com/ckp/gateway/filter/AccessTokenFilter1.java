package com.ckp.gateway.filter;

import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import com.netflix.zuul.exception.ZuulException;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public class AccessTokenFilter1 extends ZuulFilter {
	
	//设置需要添加参数accessToken且参数不能等于zuul
	@Override
	public Object run() throws ZuulException {
		RequestContext ctx = RequestContext.getCurrentContext();

		int code = ctx.getResponseStatusCode();
		System.out.println("accessToken1 response code:" + code);
		if(code == 401)
			return null;

		HttpServletRequest request = ctx.getRequest();

		Object accessToken = request.getParameter("accessToken");
		System.out.println("accessToken1:" + accessToken);
		if (accessToken == null || "zuul".equals(accessToken)) {
			ctx.setSendZuulResponse(false);
			ctx.setResponseStatusCode(402);
			return null;
		}
		return null;
	}

	@Override
	public boolean shouldFilter() {
		return true;
	}

	//执行顺序为2
	@Override
	public int filterOrder() {
		return 1;
	}

	@Override
	public String filterType() {
		return "pre";
	}

}
