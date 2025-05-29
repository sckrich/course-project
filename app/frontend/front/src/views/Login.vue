<script setup>
import { ref } from 'vue';
import axios from 'axios';
import router from '@/router';

const username = ref('');
const password = ref('');
const errorMessage = ref('');

const login = async () => {
  try {
    const response = await axios.post('http://localhost:9090/api/login/', {
      username: username.value,
      password: password.value,
    });
    
    const userdata = response.data;
    console.log('Data', userdata); // Проверяем, что мы получаем от сервера

    if (userdata && userdata.client_id) {
      localStorage.setItem('user', JSON.stringify(userdata));
      router.push({ path: `profile/${userdata.client_id}` });
    } else {
      errorMessage.value = 'Ошибка: данные пользователя отсутствуют';
      console.error('Ошибка: данные пользователя отсутствуют');
    }
  } catch (error) {
    errorMessage.value = 'Ошибка входа: ' + error.response.data.message || error.message;
    console.error('Ошибка входа:', error);
  }
};
</script>
<template>
  <div class="cover">
        <img class = "background-image" src="../../public/background.png" alt="">
  </div>
  <div class="wrapper">
    <div class = "login-wrapper">
      
      <hr class="line-up">
      <div class="login-form">
        <form @submit.prevent="login" class = "form-login">
          <h2 class = "title">Авторизация</h2>
            <p class="login-title">Ваш логин:</p>
            <input v-model="username" placeholder="Логин" class = "login-input" required />
            <div class="pass-titles">
              <p class="pass-title">Ваш пароль: </p>
              </div>
            <input type="password" v-model="password" placeholder="Пароль" required  class = "password-input"/>
            <button class = "sbmt-btn"type="submit">Войти</button>
            <div class="reg-block">
              <p class="reg-txt">У вас нет аккаунта? - </p> 
              <a class = "reg-btn" href="/register">Зарегестрируйтесь!</a>
            </div>
            <p v-if="errorMessage" style="color: red;">{{ errorMessage }}</p>
        </form>
        
      </div>
      <hr class="line">
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
.reg-btn:active{
  transform: scale(0.9);
}
.reg-btn:hover{
  transition: 0.2s ease;
  cursor: pointer;
  background-color: #252525;
  color: white;
  outline: 1px solid white;
}
.reg-btn{
  padding: 8px;
  border-radius: 16px;
  background-color: white;
  color: #303030;
  border: none;
  text-decoration: none;
  font-family: "Pixelify Sans", sans-serif;
  margin-left: 8px;
}
.reg-block{
  margin-top: 10px;
  display: flex;
  align-items: center;
}
.reg-txt{
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  font-size: 12px;
}
.line-up{
  margin-bottom: 20px;
  opacity: 0.2;
}
.line{
  margin-top: 30px;
  opacity: 0.2;
}
.login-title{
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  max-height: 8px;
}
.pass-titles{
  
  display: flex;
  flex-direction: column;
  align-items: center;
}
.pass-title{
  max-height: 8px;
  color: white;
  font-family: "Pixelify Sans", sans-serif;
}
.joke-pswd{
  margin-top: -15px ;
  font-size: 10px;
  opacity: 0.1;
  color: white;
  font-family: "Pixelify Sans", sans-serif;
}
.reg-description{
  width: 500px;
  color: white;
  font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}
.login-form{
  display: flex;
  flex-direction: column;
  margin-left: auto;
  margin-right: auto;
}

.card-image img{
  width: 200px;
  object-fit: cover;

}
.title{
  color: white;
  font-family: "Pixelify Sans", sans-serif;
}
.sbmt-btn:hover{
  cursor: pointer;
  background-color: #161616;
  outline: 1px solid white;
  color: white;
  transition: 0.1s ease;
}

.sbmt-btn:active{
  transform: scale(0.95);
}
.sbmt-btn{
  padding: 8px;
  border-radius: 16px;
  border: none;
  background-color: #ffffff;
  color: #161616;
  font-family: "Pixelify Sans", sans-serif;
  font-size: 16px;
  font-weight: 500;
  margin-top: 20px;
  }
  .password-input:focus{
    outline: 1px solid rgb(80, 151, 99);
  }
  .login-input:focus{
    outline: 1px solid rgb(80, 151, 99);

  }
  .password-input{
    background-color: #303030;
    width: 300px;
  color: white;
  padding: 8px;
  border: none;
  border-radius: 16px;
  outline: 1px solid #648845;
  margin-top: 10px;
  }
  .login-input{
    margin-top: 10px;
    background-color: #303030;
    width: 300px;
  color: white;
  padding: 8px;
  border: none;
  border-radius: 16px;
  outline: 1px solid #648845;
  }
  .form-login{
    min-height: 200px;
    width: 350px;
    padding: 8px;
    background-color: #252525;
    border-radius: 24px;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-left: auto;
    margin-right: auto;
    min-height: 300px;
  }
  .wrapper{
    width: 100vw;
    background-color: #161616;
    display: flex;
  }
  .login-wrapper{
    margin-left: auto;
    margin-right: auto;
    min-height: 30vw;
    width: 80vw;
    background-color: #161616;
  }
  .background-image{
    transform: rotate(180deg);
  position: absolute;
  top: 0;
  left: 0;
  z-index: -1;
  object-fit: cover;
  width: 100vw;
  height: 100%;
  object-fit: cover;
}
</style>
  