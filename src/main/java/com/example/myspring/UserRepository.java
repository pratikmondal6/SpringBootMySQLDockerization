package com.example.myspring;


import com.example.myspring.User;
import org.springframework.data.jpa.repository.JpaRepository;

// Use extends to inherit from JpaRepository
public interface UserRepository extends JpaRepository<User, Long> {

    // No need to override flush() method, it's already defined in JpaRepository
}
