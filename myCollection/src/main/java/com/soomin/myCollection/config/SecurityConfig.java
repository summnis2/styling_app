package com.soomin.myCollection.config; // 이 파일의 위치입니다.

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.header.writers.frameoptions.XFrameOptionsHeaderWriter;

@Configuration //설정정보
@EnableWebSecurity //기존 보안 대신 새규칙 적용
public class SecurityConfig {

    @Bean // 이 메서드가 반환하는 객체를 스프링이 보안 관리자로 등록합니다.
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // 1. 접근 권한 설정 (화살표 함수 'auth ->' 사용)
                .authorizeHttpRequests(auth -> auth
                        // "/**" (모든 주소)에 대해 permitAll() (전부 허용) 하겠다는 뜻입니다.
                        // 이 줄 덕분에 로그인 창 없이 우리가 만든 회원가입 페이지에 들어갈 수 있어요.
                        .requestMatchers("/**").permitAll()
                        // 그 외의 요청은 로그인이 필요하다는 뜻이지만, 위에서 다 열어줬으므로 현재는 무사통과입니다.
                        .anyRequest().authenticated()
                )

                // 2. CSRF(사이트 간 요청 위조) 보안 설정
                .csrf(csrf -> csrf
                        // 우리가 DB 확인용으로 쓸 H2 콘솔 주소만 보안 검사를 끄겠다는 설정입니다.
                        .ignoringRequestMatchers("/h2-console/**")
                )

                // 3. 페이지 헤더 설정
                .headers(headers -> headers
                        // H2 콘솔은 화면 안에 화면을 띄우는(iframe) 방식이라 보안상 막힐 수 있는데,
                        // "우리 사이트 안에서 띄우는 건 허용해줘"라고 설정하는 부분입니다.
                        .frameOptions(frame -> frame.sameOrigin())
                );

        return http.build(); // 설정한 내용을 묶어서 반환합니다.
    }
}