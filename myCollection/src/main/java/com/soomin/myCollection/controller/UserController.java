package com.soomin.myCollection.controller;

import com.soomin.myCollection.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequiredArgsConstructor // "UserService를 자동으로 연결해줘"
@Controller // "내가 바로 주소를 담당하는 컨트롤러다!"
@RequestMapping("/user") // 이 컨트롤러의 모든 주소는 /user로 시작합니다.
public class UserController {

    private final UserService userService;

    // 1. 회원가입 화면 보여주기
    @GetMapping("/signup")
    public String signup() {
        return "signup_form"; // 우리가 만든 signup_form.html을 보여줍니다.
    }

    // 2. [가입하기] 버튼 눌렀을 때 실행 (데이터 저장)
    @PostMapping("/signup")
    public String signup(@RequestParam("username") String username,
                         @RequestParam("email") String email,
                         @RequestParam("password") String password) {

        // 서비스에게 데이터를 전달해서 DB에 저장하라고 시킵니다.
        userService.create(username, email, password);

        // 작업이 끝나면 메인 페이지로 이동합니다.
        return "redirect:/";
    }
}