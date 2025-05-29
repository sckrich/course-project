import axios from 'axios';

const API_URL = 'http://localhost:9090/api/token/';

export const authService = {
  login(username, password) {
    return axios.post(API_URL, { username, password })
      .then(response => {
        if (response.data.access) {
          localStorage.setItem('user', JSON.stringify(response.data));
        }
        return response.data;
      })
      .catch(error => {
        throw new Error(error.response.data.detail || 'Ошибка авторизации');
      });
  },
  logout() {
    localStorage.removeItem('user');
  },
  getCurrentUser() {
    return JSON.parse(localStorage.getItem('user'));
  }
};
