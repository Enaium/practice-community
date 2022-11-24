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
import BulletinBoard from '@/components/BulletinBoard.vue';
import PostInformation from '@/components/PostInformation.vue';
import http from "@/util/http.js";
import {onMounted, reactive} from "vue";
import {createToast} from "mosha-vue-toastify";

const data = reactive({
  posts: [],
  hasLogin: false,
  page: {
    total: 0,
    current: 0,
    count: 10,
    type: 'CREATE'
  }
});

onMounted(() => {
  http.get("/auth/hasLogin").then(r => {
    data.hasLogin = r.data.data
  })
  change()
  http.get("/post/get/count").then(r => {
    data.page.total = r.data.data
  })
})

const previous = () => {
  if (data.page.current > 0) {
    data.page.current--
  }
  change()
}

const next = () => {
  if (data.page.current < Math.floor(data.page.total / data.page.count)) {
    data.page.current++
  }
  change()
}

const selectIndex = (index) => {
  data.page.current = index - 1
  change()
}

const selectType = (type) => {
  data.page.type = type
  change()
}

const change = () => {
  http.post("/post/get", data.page).then(r => {
    data.posts = r.data.data
  })
}

const logout = () => {
  http.get("/auth/logout").then(r => {
    if (r.data.data) {
      createToast("logout successfully")
    }
  })
}

</script>
<template>
  <BulletinBoard/>
  <div class="mt-5"></div>
  <div class="container">
    <div class="row">
      <div class="col">
        <div class="card">
          <div class="card-body">
            <div class="btn-group" role="group" aria-label="Basic example">
              <button type="button" class="btn btn-primary" @click="selectType('CREATE')">Latest Post</button>
              <button type="button" class="btn btn-primary" @click="selectType('UPDATE')">Latest Comment</button>
            </div>

            <ul class="list-group mt-2">
              <PostInformation v-for="post in data.posts" :data="post"/>
            </ul>


            <nav aria-label="Page navigation example" class="mt-2 d-flex justify-content-center">
              <ul class="pagination">
                <li class="page-item"><a class="page-link" @click="previous">Previous</a></li>
                <li class="page-item" v-for="index in Math.ceil(data.page.total / data.page.count)"><a
                    class="page-link" :class="{ active: index === data.page.current + 1 }"
                    @click="selectIndex(index)">{{ index }}</a></li>
                <li class="page-item"><a class="page-link" @click="next">Next</a></li>
              </ul>
            </nav>
          </div>
        </div>
      </div>
      <div class="col-md-auto">
        <div class="card">
          <div class="card-header">
            Community
          </div>
          <div class="card-body">
            <div v-if="data.hasLogin">
              <div class="d-flex flex-column gap-1">
                <button type="button" class="btn btn btn-primary"
                        @click="this.$router.push({ path: '/writer' })">Writer
                </button>

                <button type="button" class="btn btn btn-primary"
                        @click="this.$router.push({ name: 'Me', params:{ id : 1} })">Me
                </button>

                <button type="button" class="btn btn btn-danger"
                        @click="logout">Logout
                </button>
              </div>
            </div>
            <div v-else>
              <div class="d-flex flex-column gap-1">
                <button type="button" class="btn btn btn-primary"
                        @click="this.$router.push({ path: '/login' })">Login
                </button>
                <button type="button" class="btn btn btn-primary"
                        @click="this.$router.push({ path: '/register' })">Register
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>