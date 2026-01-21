package com.soomin.myCollection.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

@Entity //db만들어라

public class SiteUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //DB가 알아서 1씩 올려 저장하게끔
    private Long id;

    @Column(unique =true) //중복방지 (unique =true)
    private String username;

    private String password;

    @Column(unique = true)
    private String email;
}
