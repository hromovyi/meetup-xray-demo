package com.github.hromovyi.xraydemo.configuration;

import com.amazonaws.xray.AWSXRay;
import com.amazonaws.xray.AWSXRayRecorderBuilder;
import com.amazonaws.xray.javax.servlet.AWSXRayServletFilter;
import com.amazonaws.xray.plugins.EC2Plugin;
import com.amazonaws.xray.plugins.ElasticBeanstalkPlugin;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;

import javax.servlet.Filter;

@Configuration
public class WebConfig {

    @Bean
    @Order(10)
    public Filter TracingFilter() {
        return new AWSXRayServletFilter("attributes-manager");
    }

    @Bean
    @Order(20)
    public Filter CorrelationIdFilter() {
        return new CorrelationIdFilter();
    }

    @Bean
    public Filter SimpleCORSFilter() {
        return new SimpleCORSFilter();
    }

    static {
        AWSXRayRecorderBuilder builder = AWSXRayRecorderBuilder.standard()
                .withPlugin(new EC2Plugin()).withPlugin(new ElasticBeanstalkPlugin());
        AWSXRay.setGlobalRecorder(builder.build());
    }
}
