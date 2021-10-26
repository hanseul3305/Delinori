package com.noriteo.delinori.qna;

import com.noriteo.delinori.common.config.RootConfig;
import com.noriteo.delinori.common.security.config.SecurityConfig;
import com.noriteo.delinori.common.security.domain.SecurityMember;
import com.noriteo.delinori.common.security.mapper.SecurityMapper;
import com.noriteo.delinori.member.domain.Member;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {RootConfig.class, SecurityConfig.class})
public class PasswordTests {

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    SecurityMapper securityMapper;

    @Test
    public void testMember(){
        try {

            log.warn("-------------------------------");
            log.warn(securityMapper);

            String mid = "admin0";

            SecurityMember securityMember = securityMapper.findByMid(mid);

            log.warn("--------------------------------");
            log.warn(securityMember);
        }catch(Exception e ){
            e.printStackTrace();
        }
    }
}
