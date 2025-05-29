<script setup>
import axios from 'axios';
import { ref } from 'vue';
const username = ref('')
const password = ref('')
const name = ref('')
const adress = ref('')
const email = ref('')
const avatar = ref('')
const pasport = ref()
const register = async () => {
  try {
    await axios.post('http://localhost:9090/api/register/', {
      username: username.value,
      password: password.value,
      adress: adress.value,
      pasport: pasport.value,
      name: name.value,
      email: email.value,
      avatar: avatar.value,
    });
    alert('Success')
  } catch (error) {
    console.error('Ошибка создания пользователя:', error);
  }
};
</script>
<template>
    <div class="cover">
        <img class = "background-image" src="../../public/background.png" alt="">
      </div>
    <div class="reg-wrapper">
        <div class="register">
            <hr class="upperline">
        <form @submit.prevent="register" class = "form-login">
            <h2 class = "title">Регистрация</h2>
            <p class="login-title">Ваш логин:</p>
            <input v-model="username" placeholder="Логин" class = "login-input" required />
            <div class="pass-titles">
                <p class="pass-title">Ваш пароль: </p>
            </div>
            <input type="password" v-model="password" placeholder="Пароль" required  class = "password-input"/>
            <div class="info">
                <p class = "instance-info">Обязательная информация</p>
                <input type="email" v-model="email" placeholder="Электронная почта" required  class = "email-input"/>
                <input type="name" v-model="name" placeholder="Имя" required  class = "name-input"/>
                <input type="adress" v-model="adress" placeholder="Адрес" required  class = "adress-input"/>
                <input type="pasport" v-model="pasport" placeholder="Паспорт" required  class = "pasport-input"/>
                <input type="avatar" v-model="avatar" placeholder="ссылка на аватар" required class = "avatar-input">
            </div>    
            <button class = "sbmt-btn" type="submit">Войти</button>
            <p v-if="errorMessage" style="color: red;">{{ errorMessage }}</p>
        </form>
        <hr class="outlined">
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
.upperline{
    margin-top: 20px;
    margin-bottom: 10px;
    opacity: 0.2;
}
.outlined{
    opacity: 0.2;
    margin-top: 20px;
}
.instance-info{
    
  color: white;
  font-family: "Pixelify Sans", sans-serif;
}
.pass-title{
    
  color: white;
  font-family: "Pixelify Sans", sans-serif;
}
.login-title{
  color: white;
  font-family: "Pixelify Sans", sans-serif;
}
.title{
  color: white;
  font-family: "Pixelify Sans", sans-serif;
}
.sbmt-btn{
    background-color: white;
    color: #161616;
    padding: 8px;
    border-radius: 16px;
    margin-top: 10px;
    border: none;
}
.sbmt-btn:hover{
    cursor: pointer;
    background-color: #161616;
    color: white;
    outline: 1px solid white;
    transition: 0.2s ease;
}
.background-image{
  position: absolute;
  top: 0;
  left: 0;
  z-index: -1;
  object-fit: cover;
  width: 100vw;
  height: 100%;
  object-fit: cover;
  transform: rotate(180deg);
}
.sbmt-btn:active
{
    transform: scale(0.95);
}

.form-login{
    display: flex;
    flex-direction: column;
    align-items: center;
    
}
.info{
    display: flex;
    flex-direction: column;
    align-items: center;
}
input{
    padding: 8px;
    border: none;
    border-radius: 16px;
    background-color: #303030;
    color: white;
    width: 250px;
    margin-top: 8px;
}
input:focus{
    outline: 1px solid #aeaeae;
}
    .reg-wrapper{
        width: 100vw;
        display: flex;
        background-color: #161616;
    }
    .register{
        width: 80vw;
        margin-left: auto;
        margin-right: auto;
    }

</style>