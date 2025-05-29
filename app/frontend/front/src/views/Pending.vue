<template>
  <div class="cover">
    <img class="background-image" src="../../public/background.png" alt="">
  </div>
  <div class="wrapper">
    <div class="wrapper-app" v-if="isAuthenticated">
      <h2>Новые заказы</h2>
      <ul>
        <li v-for="order in orders" :key="order.sale_number">
          <div class="info">
            <p class="title">Торт: {{ order.sale_cake_options }}</p>
            <p class="title">Кому: {{ order.client }}</p>
            <p class="title">Дата заказа: {{ order.sale_date }}</p>
            <p class="title">Кондитер: {{ order.conditioner_name }}</p>
            <p class="title">Цена заказа: {{ order.sale_cost }}</p>
            <p class="title">Вес заказа в кг: {{ order.sale_weight }}</p>
          </div>
          <div class="btns">
            <button class="confirm-btn" @click="openConfirmModal(order)">Подтвердить заказ</button>
          </div>
        </li>
      </ul>
      <div class="report-btns">
        <button type = "button" @click="generateAllReport">Отчет о всех заказах</button>
        <button type = "button" @click="generateReport">Отчет о неподтвержденных заказах</button>
      </div>
      <div v-if="selectedOrder" class="modal">
        <div class="modal-content">
          <form @submit.prevent="confirmOrder">
            <input class="pasport-input" 
              v-model="saleData.administrator_pasport" 
              placeholder="Ваш паспорт" 
              required 
            />
            <div class="left-btns">
              <button type="button" @click="confirmOrder">Подтвердить</button>
              <button type="button" @click="closeModal">Отмена</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div v-else class = "login-form">
      <h2>Вход администратора</h2>
      <form class = "log-form" @submit.prevent="login">
        <input class = "pasport-input-ad" v-model="credentials.administrator_login" placeholder="Логин администратора" required />
        <input class = "pasport-input-ad" type="password" v-model="credentials.administrator_password" placeholder="Пароль" required />
        <button type="submit">Войти</button>
      </form>
    </div>
    
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      reportUrl: null,
      orders: [],
      selectedOrder: null,
      saleData: {
        administrator_pasport: ''
      },
      isAuthenticated: false,
      credentials: {
        administrator_login: '',
        administrator_password: ''
      }
    };
  },
  created() {
    this.fetchOrders();
  },
  methods: {
    async generateReport() {
  try {
    const response = await axios.get('http://localhost:9090/api/unconfirmed-report/', {
      responseType: 'blob', 
    });
    const url = window.URL.createObjectURL(new Blob([response.data]));
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', 'Sales.html'); 
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link); 
  } catch (error) {
    console.error('Ошибка при генерации отчета:', error);
  }
},
    async fetchOrders() {
      if (!this.isAuthenticated) return;
      try {
        const response = await axios.get('http://localhost:9090/api/pending');
        this.orders = response.data;
      } catch (error) {
        console.error('Ошибка при загрузке заказов:', error);
      }
    },
    openConfirmModal(order) {
      this.selectedOrder = order;
    },
    closeModal() {
      this.selectedOrder = null;
      this.saleData = {
        sale_cost: null,
        conditioner_name: '',
        administrator_pasport: ''
      };
    },
    async confirmOrder() {
      try {
        await axios.post(`http://localhost:9090/api/confirm/${this.selectedOrder.sale_number}`, {
          ...this.saleData
        });
        this.fetchOrders();
        this.closeModal();
        alert('Заказ подтвержден!');
      } catch (error) {
        console.error('Ошибка при подтверждении заказа:', error);
      }
    },
    async login() {
      try {
        const response = await axios.post('http://localhost:9090/api/loginadmin', this.credentials);
        var data = response.data
        if (data) {
          this.isAuthenticated = true;
          this.fetchOrders();
        } else {
          alert('Неверный логин или пароль');
        }
      } catch (error) {
        console.error('Ошибка при входе:', error);
      }
    },
    async generateAllReport() {
  try {
    const response = await axios.get('http://localhost:9090/api/report/', {
      responseType: 'blob', 
    });
    const url = window.URL.createObjectURL(new Blob([response.data]));
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', 'Sales.html'); 
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link); 
  } catch (error) {
    console.error('Ошибка при генерации отчета:', error);
  }
  }
}
};
</script>

<style scoped>
.report-btns{
  display: flex;
  gap: 10px;
  margin-left: 100px;
}
.pasport-input-ad{
  border-radius: 16px;
  background-color: #151515;
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  padding:8px;
  border: 1px solid rgb(32, 32, 32);
  width: 200px;
  margin-top: 10px;
}
.log-form{
  display: flex;
  flex-direction: column;
  align-items: center;
}
.login-form{
  height: 100vh;
}
.btns{
  display: flex;
  align-items: center ;
}
.confirm-btn{
  margin-top: 20px;
}
.pasport-input{
  border-radius: 16px;
  background-color: #151515;
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  padding: 16px;
  border: none;
  width: 200px;
}
.left-btns{
  margin-left: 10px;
}
.info{
  margin-left: 50px;
}
form{
  margin-left: auto;
  margin-right: auto;
  margin-top: auto;
  margin-bottom: auto;
}
.modal{
  display: flex;
  position: fixed;
  top: 0;
  left: 0;
  background-color: rgba(0, 0, 0, 0.5);
  width: 100vw; 
  height: 100vh; 
  justify-content: center;
  align-items: center; 
  z-index: 1000;
}
li{
  display: grid;
  grid-template-columns: 600px 200px;
  width: 60vw;
  background-color: #202020;
  border: 1px solid rgb(47, 47, 47);
  border-radius: 38px;
  padding: 8px;
  margin-top: 5px;
  margin-bottom: 10px;
}
h2{
  margin-left: 100px;
  color: white;
  font-family: "Pixelify Sans", sans-serif;
}
ul{
  list-style: none;
  margin-bottom: -10px;
}
.wrapper-app{
  background-color: #151515;
}
.wrapper{
  background-color: #151515;
}
.title{
   color: white;
  font-family: "Pixelify Sans", sans-serif;
}
 .background-image{
  height: 110vh;
    transform: rotate(180deg);
  position: absolute;
  top: 0;
  left: 0;
  z-index: -1;
  width: 100vw;
}
button:hover{
  color: #333333;
  background-color: white;
  transition: 0.2s ease;
  cursor: pointer;
}
button{
  background-color: #333333;
  color: #ffffff;
  padding: 8px;
  border-radius: 16px;
  margin-top: 10px;
  border: none;
}
</style>
