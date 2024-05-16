<template lang="pug">
q-layout(view='hHh lpR fFf')
  q-header.bg-primary.text-white(bordered='')
    q-toolbar
      q-toolbar-title
        q-avatar
          img(src='https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg')
        | Title
  q-page-container
    router-view
</template>

<script setup>
</script>
