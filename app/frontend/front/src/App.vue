<script setup>
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';
</script>

<template>
  <div class="app">
    <div class="app-wrapper">
      <Header/>
      <router-view>

      </router-view>
      <Footer/>
    </div>
  </div>
</template>

<style sccoped>


.app{
  background-color: #161616;
}
.app-wrapper{
  
  height: 100vh;
  position: absolute;
  top: 0;
  left: 0;
  width: 100vw;
}

</style>