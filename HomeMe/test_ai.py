# test_ai.py
import os
import google.generativeai as genai
from dotenv import load_dotenv

# Загружаем переменные из .env
load_dotenv()

# Настройка
api_key = 'AIzaSyAzUyp0e89OyU2aCA1gb_jm8cu-qWQ6IZo'
genai.configure(api_key=api_key)

# Выбор модели.
# gemini-1.5-flash — идеальна для чат-ботов (быстрая и дешёвая)
model = genai.GenerativeModel('gemini-3-flash-preview')

print("Отправляю запрос к Gemini...")
response = model.generate_content("Напиши короткое приветствие для клиента агентства недвижимости.")

print("-" * 20)
print(response.text)
print("-" * 20)