package com.proqik.util;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class RequestLogFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("=== RequestLogFilter initialized ===");
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String uri = httpRequest.getRequestURI();
        String method = httpRequest.getMethod();
        String queryString = httpRequest.getQueryString();
        
        System.out.println("=== REQUEST: " + method + " " + uri + (queryString != null ? "?" + queryString : ""));
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        System.out.println("=== RequestLogFilter destroyed ===");
    }
}