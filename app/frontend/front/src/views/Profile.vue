<script setup>
import { onMounted, ref, watch } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import axios from 'axios';

const user = ref({});
const router = useRouter();
const route = useRoute();
const sales = ref([]);
const isOwner = ref(false);
const showed = ref(false);
const avatar_url = ref('');
function logout() {
  localStorage.removeItem('user'); 
  router.push('/login'); 
}
const EditImage = async (clientId)=>{
  try{
    await axios.post(`http://localhost:9090/api/profile/${clientId}`, {
      field_name: "client_avatar",
      value: avatar_url.value,
    })
    alert("Success")
  }
  catch(error){
    console.error('Ошибка создания пользователя:', error);
  }
}
const fetchUserData = async (clientId) => {
  try {
    const response = await axios.get(`http://localhost:9090/api/profile/${clientId}`);
    const data = response.data;
    user.value = data.client;
    sales.value = data.sales;
    const storedUser = JSON.parse(localStorage.getItem('user'));
    console.log('Stored user:', storedUser);
    if (storedUser && storedUser.client_id.toString() === clientId.toString()) {
      isOwner.value = true;
    } else {
      isOwner.value = false; 
    }

    console.log('Is owner:', isOwner.value);
    console.log('User data:', user.value);
    console.log('Sales data:', sales.value);
  } catch (error) {
    console.error("Ошибка при получении данных пользователя!", error);
    router.push({ name: 'Login' });
  }
}


onMounted(() => {
  const clientId = route.params.client_id;
  if (clientId) {
    fetchUserData(clientId);
  } else {
    console.error("client_id не найден в параметрах маршрута");
  }
});
watch(() => route.params.client_id, (newClientId) => {
  if (newClientId) {
    fetchUserData(newClientId);
  }
});
</script>
<template>
    <div class="cover">
        <img class = "background-image" src="../../public/background.png" alt="">
        
    </div>
    <div class = "wrapper">
      <div class="grid-profile-wrapper">
        <hr class="upperline">
      <div class="profile-wrapper">
        
        <div class="left-profile-img">
          <img v-if="user.client_avatar" :src="user.client_avatar" alt="">
          <img v-else src="https://avatars.mds.yandex.net/i?id=9d389804f63b0b66cbbbb606e094bfd0_l-10976941-images-thumbs&n=13" alt="">
          <button v-if="isOwner" @click = "ShowEditor()" class = "load-img" type = "button">Загрузить аватар</button>
          

          <button v-if="isOwner" class = "load-img" type = "button">Редактировать профиль</button>
        </div>
        <div class="right-info-side">
          <h2 class = "profile-title">Профиль {{ user.client_username }}</h2>
          <p class = "username-title">Рады видеть вас, {{ user.client_name }}</p>
          <p class = "username-title">Ваш ID: {{ user.client_id }}</p> 
          <p  class="email-title"> Электронная почта: {{ user.client_email }}</p>
          <div v-if="isOwner" class="main-info">
            <p class="pasport">Паспорт: {{ user.client_pasport }}</p>
            <p class="adress">Адресс: {{ user.client_adress }}</p>
          </div>
          <p v-if="isOwner" class="action">Обязательно взгляните на торт недели</p>
          <p v-else class="action">Он уже видел торт недели, а вы?!</p>
          <button v-if="isOwner" class = "logout" @click="logout">Выйти</button>
        </div>
        
      </div>
      <hr class="downline">
      <div class="client-cakes">
        <h1 v-if="isOwner"class = "your-cakes">Ваши заказы</h1>
        <h1 v-else class = "your-cakes">Заказы {{ user.client_username }}</h1>
        
        
        <div v-if="sales" class="sale-block">
          <ul>
              <li>
              <div class="upper-table">
                <p class = 'sale-date'>Дата заказа</p>
                    <hr class = "row-line">
                    <p class="sale-weight">Вес изделия</p>
                    <hr class = "row-line">
                    <p class="sale-cond">Имя кондитер</p>
                    <hr class="row-line">
                    <p class="sale-cost">Стоимость</p>
              </div>
            </li>
          </ul>
          <ul v-if="isOwner" v-for="sale in sales" :key="sale.sale_id">
            <li>
              <div class="sale-row">
                <h1 class = 'sale-date'>{{ sale.sale_date}}</h1>
                <hr class = "row-line">
                <p class="sale-weight">{{ sale.sale_weight }}</p>
                <hr class = "row-line">
                <p class="sale-cond">{{sale.conditioner_name}}</p>
                <hr class="row-line">
                <p class="sale-cost">{{ sale.sale_cost }} p.</p>
              </div>
            </li>  
            
          </ul>
          <p v-else class = "action"> Заказы пользователя {{ user.client_name }}</p>
        </div>
        <p v-else class="cake-err">Заказов нет! Исправтье это!</p>
      </div>
      
      </div>
    </div>
</template>
<style scoped>
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
.sale-row{
    margin-top: 8px;
    height: 40px;
    padding-left: 8px;
    padding-right: 8px;
    border: 1px solid #303030;
    border-radius: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.upper-table{
  margin-top: 8px;
    height: 40px;
    padding-left: 8px;
    padding-right: 8px;
    border: 1px solid #303030;
    border-radius: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
ul{
  list-style: none;
}
.sale-date{
    min-width: 200px;
    color: white;
    font-family: "Pixelify Sans", sans-serif;
    font-size: 16px;
}

.sale-cond{
    min-width: 200px;
    color: white;
    font-family: "Pixelify Sans", sans-serif;
    font-size: 16px;
}
.sale-weight{
    min-width: 200px;

    color: white;
    font-family: "Pixelify Sans", sans-serif;
    font-size: 16px;
}
.sale-cost{
    min-width: 200px;

    color: white;
    font-family: "Pixelify Sans", sans-serif;
    font-size: 16px;
}
.row-line{
    opacity: 0.2;
    height: 20px;
}
.grid-profile-wrapper{
  width: 80vw;
  margin-left: auto;
  margin-right: auto;
  background-color: #161616;
}
.client-cakes{
  width: 80vw;
  margin-left: auto;
  margin-right: auto;
  background-color: #161616;
}
.cakes-line{
  opacity: 0.2;
}
.your-cakes{
  font-family: "Pixelify Sans", sans-serif;
  color: white;
}
.cake-err{
  font-family: "Pixelify Sans", sans-serif;
  color: white;
}
.left-profile-img{
  
  display: flex;
  flex-direction: column;
  align-items: center;
  min-width: 200px;
  min-height: 200px;
  object-fit: cover;
}
.left-profile-img img{
  outline: 2px solid #7d7d7d;
  width: 200px;
  height: 200px;
  object-fit: cover;
  border-radius: 100%;
}
.logout:active{
  transform: scale(0.9);
}
.downline{
  margin-left: auto;
  margin-right: auto;
  width: 80vw;
  margin-top: 20px;
  margin-bottom: 10px;
  opacity: 0.2;
}
.upperline{
  margin-left: auto;
  margin-right: auto;
  width: 80vw;
  margin-top: 10px;
  opacity: 0.2;
}
.load-img:active{
  transform: scale(0.9);
}
.load-img:hover{
  transition: 0.2s ease;
  cursor: pointer;
  background-color: #161616;
  color: white;
  outline: 1px solid white;
}
.load-img{
  margin-top: 10px;
  color: #161616;
  background-color: white;
  padding: 8px;
  border-radius: 16px;
  border: none;
  font-family: "Pixelify Sans", sans-serif;

}
.logout:hover{
  transition: 0.2s ease;
  cursor: pointer;
  background-color: #161616;
  color: white;
  outline: 1px solid white;
}
.logout{
  color: #ffffff;
  background-color: rgb(202, 89, 89);
  padding: 8px;
  border-radius: 16px;
  border: none;
  font-family: "Pixelify Sans", sans-serif;

}
.pasport{
  font-family: "Pixelify Sans", sans-serif;
  color: white;
}
.adress{
  font-family: "Pixelify Sans", sans-serif;
  color: white;
}
.profile-title{
  font-family: "Pixelify Sans", sans-serif;
  color: white;
}
.username-title{
  font-family: "Pixelify Sans", sans-serif;
  color: white;
}
.email-title{
  font-family: "Pixelify Sans", sans-serif;
  color: white;
}
.action{
  opacity: 0.4;
  font-family: "Pixelify Sans", sans-serif;
  font-weight: 400;
  color: white;
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
.wrapper{
  min-height: 400px;
  width: 100vw;
  display: flex;
  background-color: #161616;
}
.profile-wrapper{
  display: grid;
  grid-template-columns: 300px auto;
  gap: 20px;
  width: 80vw;
  margin-left: auto;
  margin-right: auto;
}
</style>