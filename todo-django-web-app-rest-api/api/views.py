# api/views.py
from rest_framework import viewsets
from todolistapp.models import Task
from .models import Device
from .serializers import TaskSerializer
from .serializers import DeviceSerializer
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status,  viewsets

class TaskViewSet(viewsets.ModelViewSet):
    serializer_class = TaskSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Task.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response({
            'Success': True,
            'Data': [serializer.data],
            'ErrorMessage': None
        }, status=status.HTTP_201_CREATED, headers=headers)

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response({
                'Success': True,
                'Data': serializer.data,
                'ErrorMessage': None
            })

        serializer = self.get_serializer(queryset, many=True)
        return Response({
            'Success': True,
            'Data': serializer.data,
            'ErrorMessage': None
        })
        


class DeviceViewSet(viewsets.ModelViewSet):

    serializer_class = DeviceSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Device.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
