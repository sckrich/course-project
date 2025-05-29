from django.db import models


class Administrator(models.Model):
    administrator_money = models.DecimalField(max_digits=10, decimal_places=2)
    administrator_name = models.CharField(max_length=64)
    administrator_pasport = models.AutoField(primary_key=True)
    administrator_password = models.CharField(max_length=256)
    administrator_login = models.CharField(max_length=256)
    class Meta:
        db_table = 'administrator'

class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

class Cake(models.Model):
    cake_id = models.IntegerField()
    cake_figures = models.CharField(max_length=20, blank=True, null=True)
    cake_form = models.CharField(max_length=20)
    cake_date = models.DateField()
    cake_name = models.CharField(primary_key=True, max_length=30)
    sale_number = models.ForeignKey('Sale', models.DO_NOTHING, db_column='sale_number', blank=True, null=True)
    cake_letters = models.CharField(max_length=50, blank=True, null=True)
    cake_cost = models.DecimalField(max_digits=10, decimal_places=2)  
    class Meta:
        db_table = 'cake' 


class Client(models.Model):
    client_avatar = models.CharField(max_length=512)
    client_email = models.CharField(max_length=128)
    client_username = models.CharField(max_length=128)
    client_password = models.CharField(max_length = 128)
    client_name = models.CharField(max_length=64)
    client_adress = models.CharField(max_length=100)
    client_sale = models.DecimalField(max_digits=10, decimal_places=2)
    client_pasport = models.CharField(max_length=10)
    client_id = models.AutoField(primary_key=True)
    class Meta:
        db_table = 'client' 
    def __str__(self):
        return self.client_username


class Conditioner(models.Model):
    conditioner_id = models.IntegerField()
    conditioner_rang = models.CharField(max_length=10)
    conditioner_cost = models.DecimalField(max_digits=10, decimal_places=2)
    conditioner_name = models.CharField(primary_key=True, max_length=70)
    class Meta:
        db_table = 'conditioner'
    def __str__(self):
        return self.conditioner_name()



class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)



class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()



class Doing(models.Model):
    pk = models.CompositePrimaryKey('cake_name', 'conditioner_name')
    cake_name = models.ForeignKey(Cake, models.DO_NOTHING, db_column='cake_name')
    conditioner_name = models.ForeignKey(Conditioner, models.DO_NOTHING, db_column='conditioner_name')



class HomeCake(models.Model):
    id = models.BigAutoField(primary_key=True)
    cake_figures = models.CharField(max_length=20)
    cake_form = models.CharField(max_length=20)
    cake_date = models.DateField()
    cake_name = models.CharField(max_length=30)
    sale_number = models.IntegerField()
    cake_letters = models.CharField(max_length=50)
    cake_cost = models.DecimalField(max_digits=10, decimal_places=2)

class Includes(models.Model):
    cake_name = models.ForeignKey(Cake, models.DO_NOTHING, db_column='cake_name')
    ingredients_name = models.ForeignKey('Ingredients', models.DO_NOTHING, db_column='ingredients_name')
    includes_num = models.IntegerField()

class Ingredients(models.Model):
    ingredients_name = models.CharField(primary_key=True, max_length=30)
    provider_name = models.ForeignKey('Provider', models.DO_NOTHING, db_column='provider_name')
    ingredients_cost = models.DecimalField(max_digits=10, decimal_places=2)  
    ingredients_thing = models.CharField(max_length=10)
    ingredients_num = models.IntegerField()
    ingredients_datenormal = models.DateField()

 

class Provider(models.Model):
    provider_name = models.CharField(primary_key=True, max_length=30)



class Sale(models.Model):
    sale_confirm = models.BooleanField(blank = True, null = True)
    sale_date = models.DateField()
    sale_cake_options = models.CharField(max_length=255)
    sale_cost = models.DecimalField(max_digits=10, decimal_places=2)
    sale_weight = models.DecimalField(max_digits=10, decimal_places=2)
    sale_number = models.IntegerField(primary_key=True)
    conditioner_name = models.ForeignKey(Conditioner, models.DO_NOTHING, db_column='conditioner_name')
    client = models.ForeignKey(Client, models.DO_NOTHING)
    administrator_pasport = models.ForeignKey(Administrator, models.DO_NOTHING, db_column='administrator_pasport', blank=True,  null=True)
    class Meta:
        db_table = 'sale'
