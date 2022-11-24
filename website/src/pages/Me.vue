<!--
  - Copyright (c) 2022 Enaium
  - Permission is hereby granted, free of charge, to any person obtaining a copy
  - of this software and associated documentation files (the "Software"), to deal
  - in the Software without restriction, including without limitation the rights
  - to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  - copies of the Software, and to permit persons to whom the Software is
  - furnished to do so, subject to the following conditions:
  - The above copyright notice and this permission notice shall be included in all
  - copies or substantial portions of the Software.
  - THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  - IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  - FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  - AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  - LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  - OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  - SOFTWARE.
  -->

<script setup>
import {onMounted, reactive} from "vue";
import http from "@/util/http.js";
import {useRoute} from "vue-router";
import Avatar from "@/components/Avatar.vue";
import {createToast} from "mosha-vue-toastify";

const data = reactive({
  id: useRoute().params.id,
  information: {
    avatar: '',
    nickname: ''
  }
})

onMounted(() => {
  http.get(`/user/information/get/${data.id}`).then(r => {
    if (r.data.data) {
      data.information = r.data.data;
    }
  })
})

const save = () => {
  http.post("/user/information/update", data.information).then(r => {
    if (r.data.data) {
      createToast("update successfully")
    }
  })
}
</script>

<template>
  <div class="d-flex justify-content-center">
    <div class="card">
      <div class="card-header">Identity:{{ data.id }}</div>
      <div class="card-body">
        <div class="d-flex gap-3">
          <Avatar :src="data.information.avatar" style="max-width: 128px"/>
          <div class="d-flex flex-column gap-1">
            <input type="url" class="form-control" placeholder="Please input avatar url"
                   v-model="data.information.avatar">
            <input type="text" class="form-control" placeholder="Please input nickname"
                   v-model="data.information.nickname">
          </div>
        </div>
        <div class="mt-2 d-flex justify-content-end">
          <button class="btn btn-primary" @click="save">Save</button>
        </div>
      </div>
    </div>
  </div>
</template>