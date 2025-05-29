<script setup>
</script>
<template>
    <div class="Footer">
        <div class="footer-wrapper">
          <div class="footer-text">
            <p class = "Course-descr">Курсовая работа. Кондитерский интернет-магазин. Синюков Данила</p>
            <p class = "footer-end">Все права защищены, все торты съедены</p>
          </div>
          <div class="btns-wrapper">
            <button class = "footer-btn">ВКонтакте</button>
            <button class = "footer-btn">Телеграм</button>
            <button class = "footer-btn" >GitHub</button>
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
.btns-wrapper{
  background-color: #161616;
  margin-left: 385px;
  margin-top: 20px;
  margin-bottom: 50px;
}
.footer-text{
  font-family: "Londrina Solid", sans-serif;
  
  color: white;
  margin-left: auto;
  margin-right: auto;
}
.footer-btn:hover{
  color: #648845;
  background-color: #fbf3dc;
  transition: 0.1s ease;
  cursor: pointer;
}
.footer-btn{
  border: none;
  margin-left: 8px;
  padding: 8px;
  border-radius: 16px;
  color: white;
  background-color: #648845;
  font-family: "Pixelify Sans", sans-serif;
  text-decoration: none;
}
.footer-end{
  color: white;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
  text-align: center;
}

.Footer{
  width: 100vw;
  display: flex;
  background-color: #161616;
}
.footer-wrapper{
  display: flex;
  flex-direction: column;
  margin-left: auto;
  margin-right: auto;
  width: 80vw;
}
</style>