from django.shortcuts import render
from .models import Cake
from decimal import Decimal
from django.db.models import Q
from .serializers import CakeSerializer
from rest_framework import generics
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from django.contrib.auth.hashers import check_password
from django.contrib.auth.hashers import make_password
from .models import Client 
from .serializers import ClientSerializer, ConditionerSerializer, SaleSerializer, CakeSerializer
from .models import Conditioner
from .models import Sale
from rest_framework import viewsets
from rest_framework.response import Response
from .models import Cake, Sale
from .serializers import CakeSerializer, SaleSerializer
from django.utils import timezone
from .models import Administrator
from django.http import HttpResponse
from xhtml2pdf import pisa
import os
class CakeViewSet(viewsets.ViewSet):
    def list(self, request):
        cakes = Cake.objects.all()
        serializer = CakeSerializer(cakes, many=True)
        return Response(serializer.data)

    def retrieve(self, request, pk=None):
        try:
            cake = Cake.objects.get(cake_id=pk)
            serializer = CakeSerializer(cake)
            return Response(serializer.data)
        except Cake.DoesNotExist:
            return Response({'error': 'Торт не найден!'}, status=status.HTTP_404_NOT_FOUND)
        
class GenerateHTMLReportUnconfirmed(APIView):
    def get(self, request):
        # Получаем все заказы
        orders = Sale.objects.filter(~Q(sale_confirm = True) ).order_by("sale_number")

        # Создаем HTML-контент
        html_content = '''
        <html>
        <head>
            <meta charset="UTF-8">
            <title>Отчет по неподтвержденным заказам</title>
            <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        ul {
            list-style-type: none; 
            padding: 0;
        }
        li {
            background: #fff;
            margin: 10px 0;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        li:hover {
            background: #e9e9e9; 
        }
    </style>
        </head>
        <body>
            <h1>Отчет по неподтвержденным заказам</h1>
            <ul>
        '''
        for order in orders:
            html_content += f'<li>Заказ №{order.sale_number}: {order.sale_cake_options}, Цена: {order.sale_cost} руб.</li>'
        
        html_content += '''
            </ul>
        </body>
        </html>
        '''

        response = HttpResponse(html_content, content_type='text/html')
        response['Content-Disposition'] = 'attachment; filename="Sales.html"'
        
        return response
class GenerateHTMLReport(APIView):
    def get(self, request):
        # Получаем все заказы
        orders = Sale.objects.all().order_by("sale_number")

        # Создаем HTML-контент
        html_content = '''
        <html>
        <head>
            <meta charset="UTF-8">
            <title>Отчет по всем заказам</title>
            <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        ul {
            list-style-type: none; 
            padding: 0;
        }
        li {
            background: #fff;
            margin: 10px 0;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        li:hover {
            background: #e9e9e9; 
        }
    </style>
        </head>
        <body>
            <h1>Отчет по всем заказам</h1>
            <ul>
        '''
        for order in orders:
            html_content += f'<li>Заказ №{order.sale_number}: {order.sale_cake_options}, Цена: {order.sale_cost} руб.</li>'
        
        html_content += '''
            </ul>
        </body>
        </html>
        '''

        response = HttpResponse(html_content, content_type='text/html')
        response['Content-Disposition'] = 'attachment; filename="Sales.html"'
        
        return response
    
class ConditionerView(generics.ListCreateAPIView):
    queryset = Conditioner.objects.all()
    serializer_class = ConditionerSerializer
class AdminLogin(viewsets.ViewSet):
    def check_admin(self, request):
        admin_pass = request.data.get("administrator_password")
        admin_login = request.data.get("administrator_login")
        administrator = Administrator.objects.get(administrator_login = admin_login)
        if (admin_pass == administrator.administrator_password):
            return Response({
                    "success"
                    })
        else:
            return Response({"error": "Неверный пароль"}, status=status.HTTP_401_UNAUTHORIZED)
class OrderViewSet(viewsets.ViewSet):
    def list(self, request):
        pending_orders = Sale.objects.filter(sale_confirm__isnull=True)
        serializer = SaleSerializer(pending_orders, many=True)
        return Response(serializer.data)
    def confirm(self, request, pk=None):
        try:
            print(f"Trying to confirm order for sale_id: {pk}")
            sale = Sale.objects.get(sale_number=pk)
            print(f"Found sale: {sale}")


            administrator_passport = request.data.get('administrator_pasport')

            try:
                administrator = Administrator.objects.get(administrator_pasport=administrator_passport)
            except Administrator.DoesNotExist:
                return Response({'error': 'Администратор с таким паспортом не найден!'}, status=status.HTTP_404_NOT_FOUND)

            sale.administrator_pasport = administrator  
            sale.sale_confirm = True
            sale.save()  

            return Response({'status': 'Заказ подтвержден!'}, status=status.HTTP_200_OK)
        except Sale.DoesNotExist:
            return Response({'error': 'Заказ не найден!'}, status=status.HTTP_404_NOT_FOUND)

class MakeOrderView(viewsets.ViewSet):
    def get(self, request, *args, **kwargs):
            cakes = Cake.objects.all()
            conditioners = Conditioner.objects.all()
            cakes_serializer = CakeSerializer(cakes, many=True)
            conditioners_serizlizer = ConditionerSerializer(conditioners, many = True)
            return Response({
                'cakes': cakes_serializer.data,
                'conditioners': conditioners_serizlizer.data
            })
        
    def create(self, request):
        cake_options = {
            'cake_name': request.data.get('cake_name'),
            'cake_figures': request.data.get('cake_figures'),
            'cake_form': request.data.get('cake_form'),
            'cake_letters': request.data.get('cake_letters'),
            'cake_cost': request.data.get('cake_cost')
        }

        cake_options_string = (
            f"Название: {cake_options['cake_name']}, "
            f"Фигуры: {cake_options['cake_figures']}, "
            f"Форма: {cake_options['cake_form']}, "
            f"Надписи: {cake_options['cake_letters']}, "
            f"Стоимость: {cake_options['cake_cost']}"
        )


        conditioner_name = request.data.get('conditioner_name')
        try:
            conditioner = Conditioner.objects.get(conditioner_name=conditioner_name)
            conditioner_cost = conditioner.conditioner_cost
        except Conditioner.DoesNotExist:
            return Response({'error': 'Кондитер с таким именем не найден!'}, status=404)


        cake_cost = Decimal(request.data.get('cake_cost'))  
        total_cost = cake_cost + conditioner_cost  
        last_sale = Sale.objects.order_by('sale_number').last()
        new_sale_number = last_sale.sale_number + 1 if last_sale else 1
        if total_cost >= Decimal('100000000.00'):  
            return Response({'error': 'Общая стоимость не может превышать 10 цифр.'}, status=400)

        sale_data = {
            "sale_number": new_sale_number,
            "sale_cost": total_cost,
            "sale_date": timezone.now().date(),
            "sale_weight": request.data.get('sale_weight'), 
            "client": request.data.get('client_id'),  
            "conditioner_name": conditioner_name, 
            "sale_cake_options": cake_options_string 
        }

        sale_serializer = SaleSerializer(data=sale_data)
        if sale_serializer.is_valid():
            sale_serializer.save()
            return Response({'status': 'Заказ успешно создан!'}, status=status.HTTP_201_CREATED)
        
        return Response(sale_serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ClientProfileView(generics.ListAPIView):
    serializer_class = ClientSerializer  
    queryset = Client.objects.all()  

    def get(self, request, *args, **kwargs):
        client_id = self.kwargs['client_id']
        client = Client.objects.filter(client_id=client_id).first()
        sales = Sale.objects.filter(client_id=client_id)
        client_serializer = ClientSerializer(client)
        sales_serializer = SaleSerializer(sales, many=True)
        return Response({
            'client': client_serializer.data,
            'sales': sales_serializer.data
        })

    def patch(self, request, *args, **kwargs):
            client_id = self.kwargs['client_id']
            client = Client.objects.filter(client_id=client_id).first()
            if client is None:
                return Response({"error": "Client not found"}, status=status.HTTP_404_NOT_FOUND)

            new_avatar_url = request.data.get('client_avatar')

            if new_avatar_url is not None:
                client.client_avatar = new_avatar_url  
                client.save() 
                return Response(self.get_serializer(client).data, status=status.HTTP_200_OK)
            
            return Response({"error": "Invalid data"}, status=status.HTTP_400_BAD_REQUEST)
    
class RegisterView(APIView):
    def post(self, request):
        client_username = request.data.get('username')
        client_password = request.data.get('password')
        client_email = request.data.get('email')
        client_pasport = request.data.get('pasport')
        client_adress = request.data.get('adress')
        client_name = request.data.get('name')
        client_avatar = request.data.get('avatar')
        if Client.objects.filter(client_username=client_username).exists():
            return Response({"error": "Пользователь с таким именем уже существует."}, status=status.HTTP_400_BAD_REQUEST)

        if Client.objects.filter(client_email=client_email).exists():
            return Response({"error": "Пользователь с таким email уже существует."}, status=status.HTTP_400_BAD_REQUEST)

        client = Client(client_avatar = client_avatar, client_name = client_name, client_adress = client_adress, client_pasport = client_pasport, client_username=client_username, client_password=make_password(client_password), client_email=client_email)
        client.save()
        return Response({"message": "Регистрация успешна!"}, status=status.HTTP_201_CREATED)
    
class LoginView(APIView):
    def post(self, request):
        client_username = request.data.get('username')
        client_password = request.data.get('password')
        try:
            client = Client.objects.get(client_username = client_username)
            if check_password(client_password, client.client_password):
                return Response({
                    "client_avatar":client.client_avatar,
                    "client_username": client.client_username,
                    "client_email": client.client_email,
                    "client_adress": client.client_adress,
                    "client_pasport": client.client_pasport,
                    "client_name": client.client_name,
                    "client_id":client.client_id,
                    "client_sale":client.client_sale,
                    "message": "Успешный вход"}, status=status.HTTP_200_OK)
            else:
                return Response({"error": "Неверный пароль"}, status=status.HTTP_401_UNAUTHORIZED)
        except Client.DoesNotExist:
            return Response({"error": "Пользователь не найден"}, status=status.HTTP_404_NOT_FOUND)
        
class CakeList(generics.ListCreateAPIView):
    queryset = Cake.objects.all()
    serializer_class = CakeSerializer