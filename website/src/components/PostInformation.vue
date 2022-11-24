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
import {onMounted, reactive} from "vue";
import http from "@/util/http.js";
import Avatar from "@/components/Avatar.vue"

const props = defineProps({
  data: Object
})

const data = reactive({
  user: {}
})

onMounted(() => {
  http.get(`/user/information/get/${props.data.userId}`).then(r => {
    if (r.data.data) {
      data.user = r.data.data
    }
  })
})
</script>
<template>
  <li class="list-group-item d-flex flex-row align-items-center gap-1">
    <Avatar style="max-width: 64px" :src="data.user.avatar"/>
    <div class="mt-0">
      <a class="text-reset"
         @click="this.$router.push({ name: 'Post', params: { id:props.data.id } })">{{ props.data.title }}</a>
      <div>{{ props.data.content.substring(0, 50) }}</div>
      <div>{{ props.data.updateTime }}</div>
    </div>
  </li>
</template>