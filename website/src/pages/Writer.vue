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
import {useRouter} from 'vue-router'
import http from "@/util/http.js";
import {computed, onMounted, reactive} from "vue";
import {marked} from "marked";
import highlight from "highlight.js";
import {createToast} from "mosha-vue-toastify";

const router = useRouter()

const data = reactive({
  posts: [],
  post: {
    id: 0,
    title: '',
    content: '',
    draft: true
  }
})

const output = computed(() => marked(data.post.content, {
  renderer: new marked.Renderer(),
  highlight: code => highlight.highlightAuto(code).value
}))

const refresh = () => {
  http.get("/auth/id").then(r => {
    http.get(`/post/get/user/${r.data.data}`).then(r => {
      data.posts = r.data.data
      if (data.posts.length !== 0) {
        data.post = data.posts[0];
      }
    })
  })
}

onMounted(() => {
  refresh()
})

const change = (id) => {
  http.get(`/post/get/${id}`).then(r => {
    data.post = r.data.data
  })
}

const createPost = () => {
  http.post("/post/create").then(r => {
    if (r.data.code === 0) {
      refresh()
    }
  })
}

const publish = () => {
  http.post("/post/update", data.post).then(r => {
    if (r.data.data) {
      router.push({name: 'Post', params: {id: data.post.id}})
      createToast("update successfully")
    }
  })
}

</script>
<template>
  <div class="container">
    <div class="mb-2">
      <div class="card">
        <div class="card-body">
          <div class="d-flex gap-2">
            <button type="button" class="btn btn-primary" @click="createPost">New Post</button>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#view">View</button>

            <div class="modal fade" id="view" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">View</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <div class="overflow-scroll max-vh-75" v-html="output"/>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-3">
        <div class="card">
          <div class="card-body overflow-scroll min-vh-100 max-vh-100">
            <div class="list-group">
              <button type="button" v-for="post in data.posts" class="list-group-item list-group-item-action"
                      :class="{active: post.id === data.post.id}" @click="change(post.id)">
                {{ post.title.substring(0, 20) + (post.title.length > 20 ? '...' : '') }}
              </button>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-9">
        <div class="card">
          <div class="card-body min-vh-100 d-flex flex-column gap-3 justify-content-between" v-if="data.post.id !== 0">
            <div>
              <input type="text" class="form-control" placeholder="Please input title" v-model="data.post.title"/>
            </div>

            <div style="flex: 1">
              <textarea class="border border-2 rounded w-100 h-100" wrap="off"
                        placeholder="Please input content"
                        v-model="data.post.content" style="resize:none;"/>
            </div>
            <div class="form-check form-switch">
              <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault"
                     v-model="data.post.draft">
              <label class="form-check-label" for="flexSwitchCheckDefault">Draft</label>
            </div>

            <div class="mt-2">
              <button type="button" class="btn btn-primary" @click="publish">Publish</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>