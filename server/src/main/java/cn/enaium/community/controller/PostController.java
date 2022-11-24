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
import cn.enaium.community.model.dto.PostDTO;
import cn.enaium.community.model.dto.PostPageableDTO;
import cn.enaium.community.model.entity.PostEntity;
import cn.enaium.community.model.result.Result;
import cn.enaium.community.repository.PostRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * @author Enaium
 */
@RestController
@RequestMapping("/post")
public class PostController {

    private final PostRepository postRepository;

    public PostController(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    /**
     * Create a post draft
     *
     * @return post id
     */
    @PostMapping("/create")
    private Result<Long> create() {
        var record = new PostEntity();
        record.setTitle(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        record.setUserId(StpUtil.getLoginIdAsLong());
        record.setCreateTime(new Timestamp(new Date().getTime()));
        record.setUpdateTime(new Timestamp(new Date().getTime()));
        postRepository.save(record);
        return Result.normal(record.getId(), "This post created successfully");
    }

    /**
     * Get the post by ID
     *
     * @param id post id
     */
    @GetMapping("/get/{id}")
    private Result<PostEntity> get(@PathVariable("id") Long id) {
        Optional<PostEntity> byId = postRepository.findById(id);
        if (byId.isEmpty() || (byId.get().getDraft() && byId.get().getUserId() != StpUtil.getLoginIdAsLong())) {
            return Result.error("This post with ID:" + id + " does not exist");
        }

        return Result.normal(byId.get(), "Get successfully");
    }

    @GetMapping("/get/user/{user}")
    private Result<List<PostEntity>> getUser(@PathVariable("user") Long user) {
        return Result.normal(postRepository.findByUserIdOrderByUpdateTimeDesc(user), "Get successfully");
    }

    @PostMapping("/get")
    private Result<List<PostEntity>> get(@RequestBody PostPageableDTO postPageableDTO) {
        return Result.normal(postRepository.findByDraft(false, PageRequest.of(postPageableDTO.getCurrent(), postPageableDTO.getCount(), Sort.by(Sort.Direction.DESC, postPageableDTO.getType().getField()))).getContent(), "Get successfully");
    }

    @GetMapping("/get/count")
    private Result<Long> count() {
        return Result.normal(postRepository.count(), "Get successfully");
    }

    /**
     * Update the post by ID
     *
     * @param postDTO post body
     * @return true or false
     */
    @PostMapping("/update")
    private Result<Boolean> update(@RequestBody PostDTO postDTO) {
        var postEntity = postRepository.findById(postDTO.getId());

        if (postEntity.isEmpty()) {
            return Result.error("This post not found");
        }

        if (postEntity.get().getUserId() != StpUtil.getLoginIdAsLong()) {
            return Result.error("This post not your");
        }
        var entity = new PostEntity();
        BeanUtils.copyProperties(postEntity.get(), entity);
        entity.setTitle(postDTO.getTitle());
        entity.setContent(postDTO.getContent());
        entity.setDraft(postDTO.isDraft());
        entity.setUpdateTime(new Timestamp(new Date().getTime()));

        postRepository.save(entity);
        return Result.normal(true, "This post updated successfully");
    }
}
