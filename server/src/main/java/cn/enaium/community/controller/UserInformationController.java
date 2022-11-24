package cn.enaium.community.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.enaium.community.model.dto.UserInformationDTO;
import cn.enaium.community.model.entity.UserInformationEntity;
import cn.enaium.community.model.result.Result;
import cn.enaium.community.repository.UserInformationRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/user/information")
public class UserInformationController {

    private final UserInformationRepository userInformationRepository;

    public UserInformationController(UserInformationRepository userInformationRepository) {
        this.userInformationRepository = userInformationRepository;
    }

    @GetMapping("/get/{user}")
    private Result<UserInformationEntity> get(@PathVariable("user") Long user) {
        var byId = userInformationRepository.findById(user);
        if (byId.isEmpty()) {
            return Result.error("This user has no information");
        }

        return Result.normal(byId.get(), "get Successfully");
    }

    @PostMapping("/update")
    private Result<Boolean> update(@RequestBody UserInformationDTO userInformationDTO) {

        if (userInformationDTO.getNickname().isEmpty()) {
            return Result.error("Nickname is blank");
        }

        var entity = new UserInformationEntity();

        var byId = userInformationRepository.findById(StpUtil.getLoginIdAsLong());
        byId.ifPresent(userInformationEntity -> BeanUtils.copyProperties(userInformationEntity, entity));


        entity.setUserId(StpUtil.getLoginIdAsLong());
        entity.setNickname(userInformationDTO.getNickname());

        if (!userInformationDTO.getAvatar().isBlank()) {
            entity.setAvatar(userInformationDTO.getAvatar());
        }

        userInformationRepository.save(entity);

        return Result.normal(true, "Updated successfully");
    }
}
