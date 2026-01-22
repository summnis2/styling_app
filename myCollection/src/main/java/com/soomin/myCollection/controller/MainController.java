package com.soomin.myCollection.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

    @GetMapping("/")
    @ResponseBody //메인창 글자
    public String index() {
        return "메인 페이지입니다. 회원가입 완료";
    }
}