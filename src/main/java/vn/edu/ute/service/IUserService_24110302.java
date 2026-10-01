package vn.edu.ute.service;

import vn.edu.ute.entity.User;

public interface IUserService_24110302 {
    User login(String username, String password);
    boolean register(User user);
    boolean verifyOTP(String email, String otpCode);
    User findByUsername(String username);
    User findByEmail(String email);
    void update(User user);
}
