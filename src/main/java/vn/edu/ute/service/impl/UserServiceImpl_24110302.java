package vn.edu.ute.service.impl;

import org.mindrot.jbcrypt.BCrypt;
import vn.edu.ute.dao.IUserDao_24110302;
import vn.edu.ute.dao.IUserRoleDao_24110302;
import vn.edu.ute.dao.impl.UserDaoImpl_24110302;
import vn.edu.ute.dao.impl.UserRoleDaoImpl_24110302;
import vn.edu.ute.entity.User;
import vn.edu.ute.entity.UserRole;
import vn.edu.ute.service.IUserService_24110302;
import vn.edu.ute.util.EmailUtil;

public class UserServiceImpl_24110302 implements IUserService_24110302 {

    private final IUserDao_24110302 userDao = new UserDaoImpl_24110302();
    private final IUserRoleDao_24110302 roleDao = new UserRoleDaoImpl_24110302();

    @Override
    public User login(String username, String password) {
        User user = userDao.findByUsername(username);
        if (user != null && user.getStatus() != null && user.getStatus() == 1) {
            if (user.getPassword().startsWith("$2a$") || user.getPassword().startsWith("$2b$")) {
                if (BCrypt.checkpw(password, user.getPassword())) {
                    return user;
                }
            } else if (user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }

    @Override
    public boolean register(User user) {
        if (userDao.findByUsername(user.getUsername()) != null) {
            return false;
        }
        if (userDao.findByEmail(user.getEmail()) != null) {
            return false;
        }

        user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));

        if (user.getRole() == null) {
            UserRole defaultRole = roleDao.findByName("USER");
            if (defaultRole == null) {
                defaultRole = roleDao.findById(1L);
            }
            user.setRole(defaultRole);
        }

        String otpCode = EmailUtil.generateOTP();
        user.setCode(otpCode);
        user.setStatus(0);

        userDao.insert(user);
        EmailUtil.sendOTPEmail(user.getEmail(), otpCode);
        return true;
    }

    @Override
    public boolean verifyOTP(String email, String otpCode) {
        User user = userDao.findByEmail(email);
        if (user != null && user.getCode() != null && user.getCode().equals(otpCode)) {
            user.setStatus(1);
            user.setCode(null);
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }
}
