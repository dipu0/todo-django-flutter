# api/tests.py
from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase
from rest_framework_simplejwt.tokens import RefreshToken
from .models import Task

class TaskAPITests(APITestCase):
    def setUp(self):
        # Create a user
        self.user = User.objects.create_user(username='testuser', password='testpassword')
        # Create a task
        self.task = Task.objects.create(user=self.user, title='Test Task', description='Test Description', complete=False)
        # Obtain a JWT token for the user
        refresh = RefreshToken.for_user(self.user)
        self.client.credentials(HTTP_AUTHORIZATION=f'Bearer {refresh.access_token}')

    def test_get_tasks(self):
        # Test retrieving tasks
        response = self.client.get('/api/tasks/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)  # Assuming this is the only task

    def test_create_task(self):
        # Test creating a new task
        response = self.client.post('/api/tasks/', {'title': 'New Task', 'description': 'New Description', 'complete': False})
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    # Add more tests for update, delete, etc.
