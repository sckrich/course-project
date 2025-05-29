<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
const user = ref({});
const router = useRouter();
const goToProfile = () => {
  const user = localStorage.getItem('user');
  const storedUser = JSON.parse(localStorage.getItem('user'));
  if (user) {
    router.push({ path: `/profile/${storedUser.client_id}` });
  } else {
    router.push({ name: 'Login' });
  }
};
const GetuserInfo = () => {
  const storedUser = localStorage.getItem('user');
  console.log(storedUser)
  if (storedUser) {
    user.value = JSON.parse(storedUser);
  } else {
    user.value = null;
  }
}
onMounted(GetuserInfo)
</script>
<template>
    <div class="header">
        <div class="logo-wrapper">
          <h1 class = "Logotxt">CAKES</h1>
          

        </div>
        <div class="btns">
          <div class="nav">
            
          <ul>
            <li class = "nav-li">
              <router-link class = "nav-btn" to="/">Главная</router-link>
            </li>
            <li class = "nav-li">
              <router-link class = "nav-btn" to="/conditioners">Кондитеры</router-link>
            </li>
            <li class = "nav-li">
              <router-link class = "nav-btn" to="/cakes">Каталог</router-link>
            </li>
            <li v-if="user">
              <router-link class = "nav-btn" to = "/makeorder">Сделать заказ</router-link>
            </li>
            <li class = "nav-li">
              <a v-if="user" class = "nav-btn" v-on:click="goToProfile">Профиль {{ user.client_username }}</a> 
              <a v-else class = "nav-btn" v-on:click="goToProfile">Профиль</a>            
            </li>
          </ul>
          </div>
        </div>
      </div>
</template>
<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Londrina+Solid:wght@100;300;400;900&family=Madimi+One&family=Pixelify+Sans:wght@400..700&display=swap');
.londrina-solid-thin {
  font-family: "Londrina Solid", sans-serif;
  font-weight: 100;
  font-style: normal;
}
hr{
  border: solid 1px;
  color: white;
  opacity: 0.4;
}
.img-list{
    margin-left: 8px;;
  width: 20px;
  object-fit: cover;
}
.img-profile{
  margin-left: 8px;;
  width: 20px;
  object-fit: cover;
}
.reg-li{
  margin-left: 8px;
}
.registration-block{
  display: flex;
}
.reg-btn{
  color: rgb(255, 255, 255);
  padding: 8px;
  border-radius: 24px;
  outline: 1px solid black;
  text-decoration: none;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}
.sgn-btn{
  background-color: rgb(19, 19, 19);
  color: rgb(255, 255, 255);
  padding: 8px;
  border-radius: 24px;
  text-decoration: none;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}
.reg-btn:hover{
  color: rgb(255, 255, 255);
  background-color: rgb(255, 255, 255);
  transition: 0.1s ease;
}
.sgn-btn:hover{
  color: rgb(255, 255, 255);
  background-color: rgb(224, 224, 224);
  outline: 1px rgb(255, 255, 255) solid;
}

.Logo-img{
  height: 25px;
  object-fit: cover;
}
.Logotxt{
  color: #ffffff;
  font-family: "Pixelify Sans", sans-serif;
  font-weight: 800;
  font-size: 24px;
}

.logo-wrapper{
  display: flex;
  align-items: center;
}

.header{
  z-index: 10;
  margin-top: 10px;
  padding-left: 16px;
  padding-right: 16px;
  border-radius: 48px;
  margin-left: auto;
  margin-right: auto;
  width: 90vw;
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.btns{
  display: flex;
}
ul{
  display: flex;
  list-style: none;
}

.nav-li{
  display: flex;
  align-items: center;
  margin-left: 8px;
}
.nav-btn{
  font-family: "Pixelify Sans", sans-serif;
  font-weight: 400;
  text-decoration: none;
  color: rgb(255, 255, 255);
  padding: 8px;
  border-radius: 24px;
  border: none;
  outline: none;
  display: flex;
  align-items: center;
  opacity: 0.8;
}
.nav-btn:hover{
  cursor: pointer;
  backdrop-filter: blur(10px);
  color: rgb(255, 255, 255);
  outline: 1px solid rgb(255, 255, 255);
  opacity: 1;
}
.nav-btn:focus{
  cursor: pointer;
  backdrop-filter: blur(10px);
  color: rgb(255, 255, 255);
  outline: 1px solid rgb(255, 255, 255);
  opacity: 1;
}
</style>