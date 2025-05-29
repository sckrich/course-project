from rest_framework import serializers, generics
from .models import Cake
from .models import Client, Conditioner, Sale

class CakeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cake
        fields = ['cake_id', 'cake_name', 'cake_figures', 'cake_form', 'cake_cost', 'cake_letters', 'cake_date']
        
class SaleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sale
        fields = '__all__'  
        extra_kwargs = {
            'sale_cost': {'required': True},  
            'client': {'required': True},      
        }

class ConditionerSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Conditioner
        fields = '__all__'

class CakeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cake
        fields = '__all__'

class ClientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Client
        fields = '__all__'