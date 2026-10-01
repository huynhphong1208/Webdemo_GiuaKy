package vn.edu.ute.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CustomSitemeshFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // Pass-through filter compatible with Jakarta EE 10 / Tomcat 10
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
