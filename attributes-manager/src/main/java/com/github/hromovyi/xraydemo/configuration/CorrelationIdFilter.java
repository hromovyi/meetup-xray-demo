package com.github.hromovyi.xraydemo.configuration;

import com.amazonaws.xray.AWSXRay;
import com.amazonaws.xray.entities.Segment;
import org.slf4j.MDC;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CorrelationIdFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        Segment currentSegment = AWSXRay.getCurrentSegment();
        MDC.put("correlationId", currentSegment.getTraceId().toString());
        filterChain.doFilter(request, response);
    }
}