package com.soomin.myCollection.controller;

import com.soomin.myCollection.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequiredArgsConstructor //UserService 연결
@Controller //주소 담당
@RequestMapping("/user") //모든 주소 /User로 시작

public class UserController {

    private final UserService userService;

    //1. 회원가입 화면
    @GetMapping("/signup")
    public String signup() {
        return "signup_form"; //html 화면 띄우기
    }

    //2. 가입하기 실행
    @PostMapping("/signup")
    public String signup(@RequestParam("username") String username,
                         @RequestParam("email") String email,
                         @RequestParam("password") String password) {

        //db 저장
        userService.create(username, email, password);

        //완료 후 메인 이동
        return "redirect:/";
    }
}