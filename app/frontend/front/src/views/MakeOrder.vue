<script setup>
import { onMounted, ref } from 'vue';
import axios from 'axios';

const error = ref(null);
const clientLogin = ref('');
const clientId = ref('');
const SelectedFigures = ref('');
const CakeForm = ref('');
const CakeLetters = ref('');
const conditioners = ref([]);
const cakes = ref([]);
const SelectedCake = ref(null);
const CakeCost = ref('');
const CakeName = ref('');
const saleWeight = ref('');  
const selectedConditioner = ref('');  

const fetchData = async () => {
  try {
    const response = await axios.get('http://localhost:9090/api/makeorder');
    
    if (response.data.cakes) {
      cakes.value = response.data.cakes; 
      console.log('Cakes data:', cakes.value);
    } else {
      console.warn('Cakes not found in response data');
    }

    if (response.data.conditioners) {
      conditioners.value = response.data.conditioners; 
      console.log('Conditioners data:', conditioners.value);
    } else {
      console.warn('Conditioners not found in response data');
    }
  } catch (err) {
    error.value = 'Ошибка загрузки данных: ' + err.message;
    console.error('Error fetching data:', err); 
  }
};

const fetchCakeDetails = async () => {
  if (SelectedCake.value) {
    try {
      console.log(SelectedCake.value)
      const response = await axios.get(`http://localhost:9090/api/cakes/${SelectedCake.value}`);
      CakeCost.value = response.data.cake_cost;
      CakeName.value = response.data.cake_name;
      console.log(CakeCost.value, CakeName.value)
    } catch (error) {
      console.error('Ошибка при загрузке деталей торта:', error);
    }
  }
};

const mk_user_order = async () => {
  try {
    const storedUser = JSON.parse(localStorage.getItem('user'));
    console.log(storedUser.client_id)
    await axios.post('http://localhost:9090/api/makeorder', {
      client_id: storedUser.client_id.toString(),  
      cake_name: CakeName.value,  
      cake_figures: SelectedFigures.value,
      cake_form: CakeForm.value,
      cake_letters: CakeLetters.value,
      cake_cost: CakeCost.value,
      sale_weight: saleWeight.value,  
      conditioner_name: selectedConditioner.value,
    });
    alert('Заказ успешно создан!')
  } catch (error) {
    console.error('Ошибка создания заказа:', error);
    alert('Не удалось создать заказ');
  }
};

onMounted(fetchData);
</script>

<template>
      <div class="cover">
        <img class = "background-image" src="../../public/background.png" alt="">
      </div>
  <div class="reg-wrapper">
    <div class="register">
      
      <form @submit.prevent="mk_user_order" class="form-login">
        <h2 class="title">Закажите свой торт прямо сейчас</h2>

        <p class="title">Ваш торт:</p>
        <select 
          v-model="SelectedCake" 
          @change="fetchCakeDetails"
          class="login-input" 
          required
        >
          <option 
            v-for="cake in cakes" 
            :key="cake.cake_id" 
            :value="cake.cake_id"
          >
            {{ cake.cake_name }}
          </option>
        </select>

        <p class = "price-title">Цена торта: {{ CakeCost }} руб.</p>

        <select 
          v-model="SelectedFigures" 
          class="login-input" 
          required
        >
          <option value="Есть">Есть</option>
          <option value="Нет">Нет</option>
        </select>
        <p class="title">Форма для вашего торта:</p>
        <select 
          v-model="CakeForm" 
          class="login-input"
        >
          <option value="Фигурный">Фигурный</option>
          <option value="Овальный">Овальный</option>
          <option value="Круглый">Круглый</option>
          <option value="Квадратный">Квадратный</option>
          <option value="Прямоугольный">Прямоугольный</option>
        </select>
        <p class="title">Вес вашего торта:</p>
        <input 
          id="weight-input" 
          v-model="saleWeight" 
          placeholder="Введите вес сделки"
          required
        />
        <p class="title">Выберете кондитера:</p>
        <select 
          v-model="selectedConditioner"  
          class="login-input"
          required
        >
          <option 
            v-for="conditioner in conditioners" 
            :key="conditioner.conditioner_id" 
            :value="conditioner.conditioner_name"
          >
            {{ conditioner.conditioner_name }}
          </option>
        </select>
        <p class="title">Добавить надпись:</p>
        <input 
          id="letters-input" 
          v-model="CakeLetters" 
          placeholder="Введите надписи на торте"
        />
        <button class="sbmt-btn" type="submit">Купить</button>
        <p v-if="error" style="color: red;">{{ error }}</p>
      </form>
    </div>
  </div>
</template>

<style scoped>
form{
  display: flex;
  flex-direction: column;
  margin-left: auto;
  margin-right: auto;
  max-width: 600px;
}
select{
  padding: 8px;
  border-radius: 16px;
  margin: 10px;
  background-color: #2d2d2d;
  color: white;
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  width: 500px;
}
button:hover{
  color: #2d2d2d;
  background-color: white;
  cursor: pointer;
  transition: 0.2s ease;
}
button{
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  padding: 8px;
  border-radius: 16px;
  width: 100px;
  margin-top: 10px;
  background-color: #2d2d2d;
}
input{
  max-width: 500px;
  padding: 8px;
  border-radius: 16px;
  font-family:  "Pixelify Sans", sans-serif;
  background-color: #2d2d2d;
  border: none;
  color: white;
}
.title{
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  
}
.price-title{
  color: white;
  font-family: "Pixelify Sans", sans-serif;
  
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

.reg-wrapper{
  background-color: #141414;
}
</style>
