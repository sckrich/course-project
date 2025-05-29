<script setup>
import axios from 'axios';
import { ref, onMounted } from 'vue';
const conditioners = ref([]);

const loading = ref(true);
const error = ref(null);
function ShowIngredients(cake_id){

}
const fetchData = async () => {
    try {
        const response1 = await axios.get('http://localhost:9090/api/conditioners/');
        conditioners.value = response1.data;
        console.log('Raw response data:', cakes.value); // Выводим необработанные данные
        
    } catch (err){
        error.value = 'Ошибка загрузки данных: ' + err.message;

    } finally {
        loading.value = false;
    }
} 
onMounted(fetchData);
</script>
<template>
    <div class="body">
        <div class="cover">
        <img class = "background-image" src="../../public/background.png" alt="">
      </div>
      <div class="upper-container">
        <div class="left-side-info">
          <h1 class = "cake-of-week">Кондитеры</h1>
          <div class="icon-block">

          </div>
            <p class = "Hyper-description">Наши талантливые кондитеры — сердце и душа нашего веб-магазина тортов. Каждый из них приносит уникальный опыт и страсть к созданию сладких шедевров. Позвольте представить их:</p>
                <RouterLink to ="/conditioners" class = "Go-btn">Узнать подробнее</RouterLink>
        </div>
        <div class="right-side-image">
          <img class = "right-image" src="https://static.vecteezy.com/system/resources/thumbnails/050/039/564/small_2x/a-cartoon-chef-with-a-beard-and-a-white-chef-hat-png.png" alt="">
        </div>
      </div>
        <div class="third-block">
          
            <div v-if="conditioners" class="list-rows">
              
                <h1 class="page-title">
                Наши кондитеры
                </h1>
                <p class = "list-description">У нас работают самые квалифицированные кондитеры! Проверьте сами, снизу представлены все кадры нашего магазина</p>
                <hr class = "upper-line">  
                <div v-if="conditioners.length == 0" class="no-response">
                  <p class = "list-description-error"> К сожалению что-то пошло не так... Мы уже работаем над исправлением данной проблемы, приносим свои искренние извинения.</p>
                  <p class="list-description-error-down"> Однако, возможно наши кондитеры очень плохо работают.</p>
                </div>  
              <ul>
                      <li v-for="cond in conditioners" :key="cond.conditioner_id">
                          <div class="cake-row">
                              <h1 class = 'cake-title'>{{ cond.conditioner_name}}</h1>
                              <hr class = "row-line">
                              <p class="cake-form">{{ cond.conditioner_rang }}</p>
                              <hr class = "row-line">
                              <p class="cake-cost">{{cond.conditioner_cost}} р.</p>
                          </div>
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
.list-description-error-down{
  opacity: 0.06;
  font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  color: rgb(255, 255, 255);
  font-size: 18px;
}
.list-description-error{
  opacity: 0.2;
  font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  color: rgb(255, 255, 255);
  font-size: 18px;
}
.buy-btn{
  padding: 8px;
  border-radius: 16px;
  font-family: "Pixelify Sans", sans-serif;
  color: #161616;
  background-color: white;
  border: none;
}
.make-your-sale{
  color: white;
  font-family: "Pixelify Sans", sans-serif;

}
.buy-btn:active{
  transform: scale(0.9);
}
.buy-btn:hover{
 
  cursor: pointer;
  color: white;
  background-color: #161616;
  outline: 1px solid white;
}
.fourth-block{
  background-color: #161616;
  display: flex;
}
.down-line-under-button{
  margin-top: 20px;
  opacity: 0.2;
}
.redirect-to-own-cake{
  color: white;
  font-family: "Pixelify Sans", sans-serif;

  margin-top: 20px;
}
.down-cake{
  margin-left: auto;
  margin-right: auto;
  width: 80vw;
  background-color: #161616;
}
.upper-line{
  opacity: 0.2;
}
.list-description{
  font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  color: rgb(255, 255, 255);
  font-size: 18px;
}
.page-title{
  font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  color: rgb(255, 255, 255);
}
.left-side-info{
  display: flex;
  flex-direction: column;
}
ul{
    list-style: none;
}
.Go-btn{
    text-decoration: none;
    width: 200px;
  padding: 8px;
  border-radius: 16px;
  border: none;
  background-color: #1c2713;
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  font-size: 16px;
  font-weight: 500;
}
.Hyper-description{
  font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  color: rgb(255, 255, 255);
  font-size: 18px;
}
.Go-btn:hover{
  background-color: #fbf3dc;
  color: rgb(0, 0, 0);
  transition: 0.1s ease;
  cursor: pointer;
}
.right-side-image{
  width: 500px;
  height: 500px;
  object-fit: cover;
  animation-name: Appearance;
  animation-duration: 0.4s;
  animation-timing-function: cubic-bezier(.1,-.6,.2,0);
}
@-webkit-keyframes Appearance {
  0% {opacity: 0;}
  100% {opacity: 1;}
}

@-o-keyframes Appearance {
  0% {opacity: 0;}
  100% {opacity: 1;}
}

@-moz-keyframes Appearance {
  0% {opacity: 0;}
  100% {opacity: 1;}
}

@keyframes Appearance {
  0% {opacity: 0;}
  100% {opacity: 1;}
}
.icon-block{
  display: flex;
  align-items: center;
}
.fire-icon{
  animation-name: Appearance;
  animation-duration: 0.4s;
  animation-timing-function: cubic-bezier(.1,-.6,.2,0);
  height: 34px;
}
.icon{
  animation-name: Appearance;
  animation-duration: 0.4s;
  animation-timing-function: cubic-bezier(.1,-.6,.2,0);
  margin-left: 8px;
  height: 50px;
}
.cake-of-week{
  animation-name: Appearance;
  animation-duration: 0.4s;
  animation-timing-function: cubic-bezier(.1,-.6,.2,0);
  font-family: "Pixelify Sans", sans-serif;
  color: white;
  font-weight: bold;
  font-size: 44px;
}
.left-side-info{
  display: flex;
  flex-direction: column;
}
.upper-container{
  z-index: 2;
  margin-left: auto;
  margin-right: auto;
  width: 80vw;
  display: grid;
  grid-template-columns: auto auto;
}
.right-image{
    height: 470px;
    object-fit: cover;
    margin-left: 100px;
}
.page-title{
    color: white;
    font-family: "Pixelify Sans", sans-serif;
    font-size: 36px;
}
.page-description{
    color: white;
    font-family: "Pixelify Sans", sans-serif;
    font-size: 16px;
}
.cake-letters{
    width: 200px;
    color: white;
    font-family: "Pixelify Sans", sans-serif;
    font-size: 16px;
}
.cake-form{
    width: 200px;

    color: white;
    font-family: "Pixelify Sans", sans-serif;
    font-size: 16px;
}
.cake-cost{
    width: 200px;

    color: white;
    font-family: "Pixelify Sans", sans-serif;
    font-size: 16px;
}
.page-title-wrapper{
    width: 80vw;
    margin-left: auto;
    margin-right: auto;
}
.cake-title{
    width: 200px;

    color: white;
    font-family: "Pixelify Sans", sans-serif;
    font-size: 16px;
}
.row-line{
    opacity: 0.2;
    height: 20px;
}
.cake-row{
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
.list-rows{
  animation-name: Appearance;
  animation-duration: 0.4s;
  animation-timing-function: cubic-bezier(.1,-.6,.2,0);
  min-height: 400px;
    margin-top: 20px;
    width: 80vw;
    margin-left: auto;
    margin-right: auto;
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
}
.Course-descr{
  text-align: center;
  color: white;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}
.third-block{
  min-height: 200px;
  width: 100vw;
  display: flex;
  background-color: #161616;
}
.card-span{
  background-color: #648845;
  color: white;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  padding: 4px;
  border-radius: 16px;
}
.card-tittle{
  color: white;
  font-family: "Pixelify Sans", sans-serif;
}
.description-card-container{
  margin-top: -30px ;
  margin-left: 15px;
}
.cake-descp{
  color: white;
  width: 220px;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}
.card-buy:hover{
  cursor: pointer;
  background-color: #fbf3dc;
  color: #648845;
  transition: 0.1s ease;
}
.card-buy{
  padding: 6px;
  border-radius: 16px;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  color: white;
  background-color: #648845;
  border: none;
}
.buy-block{
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 220px;
  height: 20px;
}
.price{
  color: white;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}
.card-item{
  border-radius: 16px;
  width: 240px;
  height: 360px;
  border: 1px solid #303030;
}
.image-card-container{
  margin-left: auto;
  margin-right: auto;
}
.card-image{
  
  position: relative;
  margin-bottom: 10px;
  margin-top: -40px;
  margin-left: 20px;
  width: 200px;
  z-index: 2;
}
.sec-down-line{
    opacity: 0.2;
  margin-top: 20px;
}
.list-title{
  height: 50px;
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  font-size: 46px;
}
.list-items{
  display: grid;
  grid-template-columns: auto auto auto auto;
  margin-top: 60px;
}
.list-block{
  width: 80vw;
  margin-left: auto;
  margin-right: auto;
}
</style>