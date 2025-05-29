<script setup>
import TheWelcome from '../components/TheWelcome.vue'
</script>

<template>
      <div class="cover">
        <img class = "background-image" src="../../public/background.png" alt="">
      </div>
      <div class="upper-container">
        <div class="left-side-info">
          <h1 class = "cake-of-week">"Сказочный"</h1>
          <div class="icon-block">
            <img class = "fire-icon" src="../../public/Fire-icon.png" alt="">
            <img class = "icon" src="../../public/healthy-icon.png" alt="">
            <img class = "icon" src="../../public/chemical-icon.png" alt="">

          </div>
            <p class = "Hyper-description">Добро пожаловать в наш сладкий мир, где каждый торт и пирожное — это не просто десерт, а настоящее произведение искусства! Мы предлагаем вкуснейшие тортики и неповторимые пирожные, приготовленные с любовью и заботой. Почувствуйте радость от сладостей с нами! Заказывайте прямо сейчас и наслаждайтесь каждым кусочком.</p>
            <button class = "Go-btn">Узнать подробнее</button>
        </div>
        <div class="right-side-image">
          <img class = "right-image" src="../../public/main-cake-image.png" alt="">
        </div>
      </div>
      <hr class = "down-line">
      <div class="down-block">
        
        <div class="filters-container">
          <div class="filter-wrapper">
            <div class="label-wrapper">
              <img src="../../public/filters-icon.png" alt="" class="filter-icon">
              <p class = "Filter">Фильтры</p>
            </div>    
            <select name="" id="">
              <option value="1">Молекулярный</option>
              <option value="2">Диетический</option>
              <option value="3">Высоко калорийный</option>
            </select>       
          </div>
          <div class="search-wrapper">
            <div class="label-wrapper">
              <img class = "Search-icon" src="../../public/Search-icon.png" alt="">
              <p class = "Search">Поиск по названию</p>
            </div>
            <input class = "Search-input" type="search" placeholder="Введите название">
            <button class ="Search-btn" type = "button">Найти</button>
          </div>
        </div>
      </div>
      
      <div class="third-block">
        
        <div class="list-block">
          <hr class="sec-down-line">
          <h1 class = "list-title">Наши изделия</h1>
          <div class="list-items">
            <div class="card-item">
              <div class="image-card-container">
                  <img class = "card-image" src="../../public/card-main.png" alt="">
                </div>
                <div class="description-card-container">
                  <h1 class = "card-tittle">Сказочный</h1>
                  <span class = "card-span">Калорийный</span>
                  <p class = "cake-descp">Очень вкусный тортик для вас и вашего вечера</p>
                  <div class="buy-block">
                    <p class = "price">1450 р.</p>
                    <button class = "card-buy"type = "button">Купить</button>
                  </div>
              </div>  
            </div>
            <div class="card-item">
              <div class="image-card-container">
                  <img class = "card-image" src="../../public/napoleon.png" alt="">
                </div>
                <div class="description-card-container">
                  <h1 class = "card-tittle">Наполеон</h1>
                  <span class = "card-span">Высококалорийный</span>
                  <p class = "cake-descp">Тот самый бабушкин тортик уже готов</p>
                  <div class="buy-block">
                    <p class = "price">1300 р.</p>
                    <button class = "card-buy"type = "button">Купить</button>
                  </div>
              </div>  
            </div>
            <div class="card-item">
              <div class="image-card-container">
                  <img class = "card-image" src="../../public/razberry.png" alt="">
                </div>
                <div class="description-card-container">
                  <h1 class = "card-tittle">Вишневый</h1>
                  <span class = "card-span">Натуральный</span>
                  <p class = "cake-descp">Тортик с начинкой из самой свежей вишни</p>
                  <div class="buy-block">
                    <p class = "price">1100 р.</p>
                    <button class = "card-buy"type = "button">Купить</button>
                  </div>
              </div>  
            </div>
            <div class="card-item">
              <div class="image-card-container">
                  <img class = "card-image" src="../../public/tiramissu.png" alt="">
                </div>
                <div class="description-card-container">
                  <h1 class = "card-tittle">Тирамису</h1>
                  <span class = "card-span">Калорийный</span>
                  <p class = "cake-descp">Самый шоколадный тортик для специально вас</p>
                  <div class="buy-block">
                    <p class = "price">1600 р.</p>
                    <button class = "card-buy"type = "button">Купить</button>
                  </div>
              </div>  
            </div>
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
.Course-descr{
  text-align: center;
  color: white;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
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
.Search-icon{
  width: 20px;
}
.third-block{
  width: 100vw;
  display: flex;
  background-color: #161616;
}
.down-line{
  opacity: 0.2;
  color: white;
}
.Search-btn{
  padding: 8px;
  border-radius: 16px;
  border: none;
  font-family: "Pixelify Sans", sans-serif;
  margin-left: 8px;
  background-color: #303030;
  color: white;
}
.Search-btn:hover{
  cursor: pointer;
  background-color: #ffffff;
  color: #303030;
  outline: 1px solid #648845;
}
.Search-input{
  width: 400px;
  background-color: #303030;
  color: white;
  padding: 8px;
  border: none;
  border-radius: 16px;
  outline: 1px solid #648845;
}
.Search-input:focus{
  outline: 1px solid #fbf3dc;
}
select:focus{
  outline: 1px solid #fbf3dc;
}
select{
  padding: 8px;
  width: 400px;
  border-radius: 16px;
  outline: 1px solid #648845;
  border: none;
  font-family: "Pixelify Sans", sans-serif;
  background-color: #303030;
  color: white;
}
option{
  font-family: "Pixelify Sans", sans-serif;
  border: none;
  outline: none;
}
.filter-icon{
  width: 20px;
  object-fit: cover;
}
.label-wrapper{
  display: flex;
  align-items: center;
}
#filter-selection{
  padding: 2px;
}
.Search{
  margin-left: 8px;
  font-size: 18px;
  font-family: "Pixelify Sans", sans-serif;
  color: white;
}
.search-wrapper{

  align-items: center;
}
.Filter{
  font-family: "Pixelify Sans", sans-serif;
  color: white;
  font-size: 18px;
  margin-left: 8px;
}
.filter-wrapper{
  align-items: center;
  
}
.down-block{
  background-color: #161616;
  width: 100vw;
  display: flex;
}
.filters-container{
  width: 80vw;
  margin-left: auto;
  margin-right: auto;
  display: grid;
  grid-template-columns: auto auto;
  align-items: center;
}
.filters-container{
  background-color: #161616;
}
.left-side-info{
  display: flex;
  flex-direction: column;
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
.Go-btn{
  padding: 8px;
  border-radius: 16px;
  border: none;
  background-color: #1c2713;
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  font-size: 16px;
  font-weight: 500;
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
.right-image{
  margin-left: 70px;
  width: 450px;
  object-fit: cover;
}
.Hyper-description{
  font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  color: rgb(255, 255, 255);
  font-size: 18px;
}
.upper-container{
  z-index: 2;
 
  margin-left: auto;
  margin-right: auto;
  width: 80vw;
  display: grid;
  grid-template-columns: auto auto;
}
.Descr-title{
  font-family: "Pixelify Sans", sans-serif;
  font-weight: 400;
  color: white;
  text-align: center;
  margin-left: auto;
  margin-right: auto;
}
hr{
  
  opacity: 0.3;
}
.info{
  padding: 8px;
  width: 75vw;
  margin-left: auto;
  margin-right: auto;
  display: grid;
  grid-template-columns: auto auto;
  gap: 20px;
}
.cake-image{
  width: 200px;
  object-fit: cover;
  border-radius: 24px;
}
.outline{
  margin-top: -10px;
  width: 20vw;
}
.right-text{
  color: white;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}
.description{
  text-align: center;
  font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  width: 60vw;
  margin-right: auto;
  margin-left: auto;
  color: white;
}
.londrina-solid-light {
  font-family: "Londrina Solid", sans-serif;
  font-weight: 300;
  font-style: normal;
}
.container{
  position: absolute;
  margin-top: 400px;
  height: 100vh;
  width: 100vw;
  background-color: #1c201f;
}
.londrina-solid-regular {
  font-family: "Londrina Solid", sans-serif;
  font-weight: 400;
  font-style: normal;
}

.londrina-solid-black {
  font-family: "Londrina Solid", sans-serif;
  font-weight: 900;
  font-style: normal;
}
.title{
  font-family: "Pixelify Sans", sans-serif;
  font-weight: 400;
  color: white;
  text-align: center;
  margin-left: auto;
  margin-right: auto;
}
.content{
  position: relative;
  margin-top: -380px;
  margin-left: auto;
  margin-right: auto;
  width: 80vw;
  height: 130vh;
  border-radius: 20px;
  z-index: 10;
  backdrop-filter: blur(20px);
}

hr{
  margin-top: 0px;
  width: 80vw;
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

</style>
