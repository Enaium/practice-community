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
import http from "@/util/http.js";
import {reactive} from "vue";
import {createToast} from "mosha-vue-toastify";

const data = reactive({
  form: {
    username: '',
    password: '',
    re_enter_password: ''
  }
})

const register = () => {
  if (data.form.password === data.form.re_enter_password) {
    http.post("/auth/register", data.form).then(r => {
      if (r.data.data) {
        createToast("register successfully")
      }
    })
  } else {
    createToast("doesn't match")
  }
}
</script>
<template>
  <div class="vh-100 d-flex justify-content-center align-items-center">
    <div class="shadow-sm p-3 mb-5 bg-body rounded">
      <form>
        <div class="mb-3">
          <label class="form-label">Username</label>
          <input type="email" class="form-control" v-model="data.form.username">
        </div>
        <div class="mb-3">
          <label class="form-label">Password</label>
          <input type="password" class="form-control" v-model="data.form.password">
        </div>
        <div class="mb-3">
          <label class="form-label">Re-enter the password</label>
          <input type="password" class="form-control" v-model="data.form.re_enter_password">
        </div>
        <p class="text-muted">
          Already have an
          <router-link to="/login" class="text-reset">account?</router-link>
        </p>
        <div class="d-grid gap-2">
          <button type="button" class="btn btn-primary d-grid gap-2" @click="register">Register</button>
        </div>
      </form>
    </div>
  </div>
</template>