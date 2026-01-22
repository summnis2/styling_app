package com.soomin.myCollection.repository;

import com.soomin.myCollection.entity.SiteUser;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<SiteUser, Long> { //DB 관리 도구
    //아이디로 사용자 차즌ㄴ 기능
    //나중에 구현
}
