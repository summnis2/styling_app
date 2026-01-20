package com.soomin.myCollection.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

@Entity

public class SiteUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique =true) //중복방지
    private String username;

    private String password;

    @Column(unique = true)
    private String email;
}
