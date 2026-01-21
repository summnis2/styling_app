package com.soomin.myCollection.service;

import com.soomin.myCollection.entity.SiteUser;
import com.soomin.myCollection.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service // "나는 비즈니스 로직을 담당하는 서비스야"
public class UserService {

    private final UserRepository userRepository;

    public SiteUser create(String username, String email, String password) {
        SiteUser user = new SiteUser();
        user.setUsername(username);
        user.setEmail(email);

        // 중요! 비밀번호를 그냥 저장하면 위험해요.
        // BCryptPasswordEncoder를 사용해 암호화해서 저장합니다.
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        user.setPassword(passwordEncoder.encode(password));

        this.userRepository.save(user); // DB 리모컨으로 저장!
        return user;
    }
}