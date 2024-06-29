# views.py

from rest_framework import viewsets

from .serializers import RolesSerializer, LoginSerializer
from .models import Login, Roles
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken

class RolesViewSet(viewsets.ModelViewSet):
    queryset = Roles.objects.all()
    serializer_class = RolesSerializer


class LoginViewSet(viewsets.ModelViewSet):
    queryset = Login.objects.all()
    serializer_class = LoginSerializer
    
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        # Call set_password before saving the instance
        serializer.validated_data['contrasena'] = request.data['contrasena']
        instance = serializer.save()
        instance.set_password(request.data['contrasena'])
        instance.save()

        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
    def update(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)

        # Check if 'contrasena' is present in the request data
        if 'contrasena' in request.data:
            instance.set_password(request.data['contrasena'])
        
        # Save the instance after updating the password
        instance.save()

        return Response(serializer.data)

from django.http import Http404
from .models import Login  # Import your User model

class LoginAPIView(APIView):
    def post(self, request, *args, **kwargs):
        print(f"Received data: {request.data}")
        email = request.data.get('correo', None)
        password = request.data.get('contrasena', None)

        try:
            # Use get_object_or_404 to handle DoesNotExist
            user = Login.objects.get(correo=email)
        except Login.DoesNotExist:
            raise Http404("User does not exist")

        if user.check_password(password):
            # Authentication successful
            refresh = RefreshToken.for_user(user)
            serializer = LoginSerializer(user)
            data = {
                'refresh': str(refresh),
                'access': str(refresh.access_token),
                'user': serializer.data
            }
            return Response({'detail': 'Valid credentials'}, status=status.HTTP_200_OK)
        else:
            print("Authentication failed")
            return Response({'detail': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)
