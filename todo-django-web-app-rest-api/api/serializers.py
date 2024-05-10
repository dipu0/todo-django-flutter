# api/serializers.py
from rest_framework import serializers
from todolistapp.models import Task
from .models import Device

class TaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Task
        fields = ['id', 'title', 'description', 'complete', 'created']

class DeviceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Device
        fields = ['id', 'device_token', 'device_type', 'active']