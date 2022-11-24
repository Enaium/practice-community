<!--
  - Copyright (c) 2022 Enaium
  -
  - Permission is hereby granted, free of charge, to any person obtaining a copy
  - of this software and associated documentation files (the "Software"), to deal
  - in the Software without restriction, including without limitation the rights
  - to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  - copies of the Software, and to permit persons to whom the Software is
  - furnished to do so, subject to the following conditions:
  -
  - The above copyright notice and this permission notice shall be included in all
  - copies or substantial portions of the Software.
  -
  - THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  - IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  - FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  - AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  - LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  - OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  - SOFTWARE.
  -
  -->

<script setup>
import {computed, onMounted, reactive} from "vue";
import {useRoute} from "vue-router";
import http from "@/util/http.js";
import {marked} from "marked";
import highlight from "highlight.js";
import PostCommentInformation from "@/components/PostCommentInformation.vue"
import {createToast} from "mosha-vue-toastify";

const data = reactive({
  post: {
    id: 0,
    content: ''
  },
  comment: '',
  comments: []
})

onMounted(() => {
  http.get(`/post/get/${useRoute().params.id}`).then(r => {
    data.post = r.data.data
    pushComment()
  })
})

let index = 0

const pushComment = () => {
  http.post("/comment/get", {
    postId: data.post.id,
    current: index,
    count: 10
  }).then(r => {
    if (r.data.data) {
      r.data.data.forEach(c => {
        data.comments.push(c)
      })
      index++
    }
  })
}

const output = computed(() => marked(data.post.content, {
  renderer: new marked.Renderer(),
  highlight: code => highlight.highlightAuto(code).value
}))

const publishComment = () => {
  if (data.post.id !== 0) {
    http.post("/comment/publish", {
      comment: data.comment,
      postId: data.post.id
    }).then(r => {
      if (r.data.code === 0) {
        data.comment = "";
        createToast("publish successfully")
      }
    })
  }
}
</script>
<template>
  <div class="container">
    <div class="card">
      <div class="card-header">
        {{ data.post.title }}
      </div>
      <div class="card-body">
        <div v-html="output"/>
      </div>
    </div>
    <div class="mt-2"></div>
    <div class="card">
      <div class="card-header">
        Publish Comment
      </div>
      <div class="card-body">
        <div class="d-flex flex-column gap-2">
          <textarea class="border border-2 rounded" placeholder="Please input comment"
                    v-model="data.comment" style="resize:none;"/>
          <button type="button" class="btn btn-primary" @click="publishComment">Publish comment</button>
        </div>
      </div>
    </div>
    <div class="mt-2"></div>
    <div class="card">
      <div class="card-header">
        Comments
      </div>
      <div class="card-body">
        <ul class="list-group mt-2">
          <PostCommentInformation v-for="comment in data.comments" :data="comment"/>
        </ul>
        <button class="btn btn-primary w-100 mt-1" @click="pushComment">More comment</button>
      </div>
    </div>
  </div>
</template>