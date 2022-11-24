/*
 * Copyright (c) 2022 Enaium
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

package cn.enaium.community.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.enaium.community.model.dto.UserDTO;
import cn.enaium.community.model.entity.UserEntity;
import cn.enaium.community.model.result.Result;
import cn.enaium.community.repository.UserRepository;
import cn.enaium.community.util.DigestUtil;
import org.springframework.web.bind.annotation.*;

/**
 * @author Enaium
 */
@RestController
@RequestMapping("/auth")
public class AuthController {

    private final UserRepository userRepository;

    public AuthController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    /**
     * Login
     *
     * @param userDTO username and password
     * @return result
     */
    @PostMapping("/login")
    public Result<String> login(@RequestBody UserDTO userDTO) {
        if (userDTO.getUsername().isBlank() || userDTO.getPassword().isBlank()) {
            return Result.error("The username or password is blank");
        }

        var userEntity = userRepository.findByUsername(userDTO.getUsername());
        if (userEntity == null) {
            return Result.error("The username not exist");
        }

        if (!DigestUtil.md5(userDTO.getPassword()).equals(userEntity.getPassword())) {
            return Result.error("The password is incorrect");
        }
        return Result.normal(StpUtil.createLoginSession(userEntity.getId()), "Successfully login");
    }

    /**
     * Register
     *
     * @param userDTO username and password
     * @return result
     */
    @PostMapping("/register")
    public Result<Boolean> register(@RequestBody UserDTO userDTO) {
        if (userDTO.getUsername().isBlank() || userDTO.getPassword().isBlank()) {
            return Result.error("The username or password is blank");
        }

        var userEntity = userRepository.findByUsername(userDTO.getUsername());
        if (userEntity != null) {
            return Result.error("The username already exist");
        }
        userRepository.save(new UserEntity() {{
            setUsername(userDTO.getUsername());
            setPassword(DigestUtil.md5(userDTO.getPassword()));
        }});
        return Result.normal(true, "Successfully registered");
    }

    @GetMapping("/hasLogin")
    public Result<Boolean> hasLogin() {
        return Result.normal(StpUtil.isLogin(), "");
    }

    @GetMapping("/id")
    public Result<Long> id() {
        return Result.normal(StpUtil.getLoginIdAsLong(), "");
    }

    @GetMapping("/logout")
    public Result<Boolean> logout() {
        StpUtil.logout();
        return Result.normal(true, "");
    }
}
