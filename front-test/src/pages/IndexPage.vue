<template lang="pug">
q-page.flex.flex-center
  q-list(bordered padding)
    q-item-label(header)="Tasks"
    q-item(tag="label" v-ripple v-for="task in tasks" :key="task.id")
      q-item-section(side top)
        q-checkbox(v-model="task.is_completed")
      q-item-section
        q-item-label="{{ task.name }}"
        q-item-label(caption)="{{ task.due_date }}"
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { api } from 'src/boot/axios'
import consumer from 'src/lib/cable'

const tasks = ref([])

const load = () =>
  api.get('/tasks')
    .then(response => tasks.value = response.data)
    .catch(console.error)

onMounted(() => {
  load()
  consumer.subscriptions.create('TasksNotificationsChannel', {
    connected: () => console.log('Connected to tasks_notifications_channel'),
    disconnected: () => console.log('Disconnected from tasks_notifications_channel'),
    received: data => {
      console.log('Received data:', data)
      load()
    }
  })
})
</script>
