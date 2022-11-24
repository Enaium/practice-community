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
import cn.enaium.community.model.dto.PostCommentDTO;
import cn.enaium.community.model.dto.PostCommentPageableDTO;
import cn.enaium.community.model.entity.PostCommentEntity;
import cn.enaium.community.model.entity.PostEntity;
import cn.enaium.community.model.result.Result;
import cn.enaium.community.repository.PostCommentRepository;
import cn.enaium.community.repository.PostRepository;
import cn.enaium.community.repository.UserInformationRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * @author Enaium
 */
@RestController
@RequestMapping("/comment")
public class PostCommentController {

    private final PostCommentRepository postCommentRepository;
    private final PostRepository postRepository;

    private final UserInformationRepository userInformationRepository;

    public PostCommentController(PostCommentRepository postCommentRepository, PostRepository postRepository, UserInformationRepository userInformationRepository) {
        this.postCommentRepository = postCommentRepository;
        this.postRepository = postRepository;
        this.userInformationRepository = userInformationRepository;
    }

    @PostMapping("/publish")
    private Result<Boolean> publish(@RequestBody PostCommentDTO postCommentDTO) {
        var postEntityOptional = postRepository.findById(postCommentDTO.getPostId());
        if (postEntityOptional.isEmpty()) {
            return Result.error("This post does not exist");
        }

        if (postCommentDTO.getComment().isBlank()) {
            return Result.error("Comment can't blank");
        }

        if (!userInformationRepository.existsByUserId(StpUtil.getLoginIdAsLong())) {
            return Result.error("You must create user information");
        }

        var postEntity = new PostEntity();
        BeanUtils.copyProperties(postEntityOptional.get(), postEntity);
        postEntity.setUpdateTime(new Timestamp(new Date().getTime()));
        postRepository.save(postEntity);

        var postCommitEntity = new PostCommentEntity();
        postCommitEntity.setPostId(postCommentDTO.getPostId());
        postCommitEntity.setUserId(StpUtil.getLoginIdAsLong());
        postCommitEntity.setComment(postCommentDTO.getComment());
        postCommitEntity.setDel(false);
        postCommitEntity.setCreateTime(new Timestamp(new Date().getTime()));
        postCommentRepository.save(postCommitEntity);

        return Result.normal(true, "publish successfully");
    }

    /**
     * Get All post
     *
     * @param postCommentPageableDTO pageable
     * @return post comment list
     */
    @PostMapping("/get")
    public Result<List<PostCommentEntity>> get(@RequestBody PostCommentPageableDTO postCommentPageableDTO) {
        if (postCommentRepository.existsByPostId(postCommentPageableDTO.getPostId())) {
            return Result.normal(postCommentRepository.findByPostIdAndDel(postCommentPageableDTO.getPostId(), false, PageRequest.of(postCommentPageableDTO.getCurrent(), postCommentPageableDTO.getCount(), Sort.by(Sort.Direction.DESC, "createTime"))).getContent(), "Get successfully");
        }
        return Result.error("it empty");
    }
}
