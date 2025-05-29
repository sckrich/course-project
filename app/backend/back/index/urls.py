from django.urls import path
from .views import CakeList
from .views import RegisterView
from .views import LoginView
from .views import ClientProfileView
from .views import ConditionerView
from .views import MakeOrderView
from .views import OrderViewSet
from .views import CakeViewSet
from .views import AdminLogin, GenerateHTMLReport, GenerateHTMLReportUnconfirmed
urlpatterns = [
    path('unconfirmed-report/', GenerateHTMLReportUnconfirmed.as_view(), name="pdf-report-uncomfirmed"),
    path('report/', GenerateHTMLReport.as_view(), name="pdf-report"),
    path('loginadmin', AdminLogin.as_view({'post':'check_admin'}), name = "check-admin"),
    path('cakes/<int:pk>', CakeViewSet.as_view({'get': 'retrieve'}), name='cake-detail'),
    path('confirm/<int:pk>', OrderViewSet.as_view({'post': 'confirm'}), name='confirm-order'),
    path('pending', OrderViewSet.as_view({'get': 'list'}), name='pending-orders'),
    path('login/', LoginView.as_view()),
    path('cakes/', CakeList.as_view(), name='product_list'), 
    path('register/', RegisterView.as_view(), name = 'registration'),
    path('profile/<int:client_id>', ClientProfileView.as_view(), name = "profile"),
    path('conditioners/', ConditionerView.as_view(), name="conditioners"),
    path('getcake', MakeOrderView.as_view({'get': 'get'}), name="make-order"),
    path('makeorder', MakeOrderView.as_view({'post':'create'}), name="make-order"),
]
